import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:possibilico/screens/wrapper.dart';
import 'package:possibilico/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'firebase_options.dart';
import 'dart:convert';

/*
  _____                        _   _       _   _   _                
 |  __ \                      (_) | |     (_) | | (_)               
 | |__) |   ___    ___   ___   _  | |__    _  | |  _    ___    ___  
 |  ___/   / _ \  / __| / __| | | | '_ \  | | | | | |  / __|  / _ \ 
 | |      | (_) | \__ \ \__ \ | | | |_) | | | | | | | | (__  | (_) |
 |_|       \___/  |___/ |___/ |_| |_.__/  |_| |_| |_|  \___|  \___/ 
*/
// Donato Clemente, Joaquin Garcia, Hector Hinojosa, Miguel Ramirez

/*
 _____                     _           
|_   _|                   | |        _ 
  | |    ___   ______   __| |  ___  (_)
  | |   / _ \ |______| / _` | / _ \    
  | |  | (_) |        | (_| || (_) | _ 
  \_/   \___/          \__,_| \___/ (_)
(As of 11/23/22)
- Firebase is currently not working, implement Firebase -> Main Page.

*/

/*
______                      _    _
|  ___|                    | |  (_)                   
| |_    _   _  _ __    ___ | |_  _   ___   _ __   ___ 
|  _|  | | | || '_ \  / __|| __|| | / _ \ | '_ \ / __|
| |    | |_| || | | || (__ | |_ | || (_) || | | |\__ \
\_|     \__,_||_| |_| \___| \__||_| \___/ |_| |_||___/
*/

//Main function, will initialize to Firebase and then go into Homepage.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HomePage());
}

//Parsed Course Data
List<CourseData> parseCourseData(String responseBody) {
  final parsed = jsonDecode(responseBody)['data']['courseInfos'];
  return parsed.map<CourseData>((json) => CourseData.fromJson(json)).toList();
}

//Requests JSON Data from UTRGV Servers
Future<List<CourseData>> fetchCourseData(http.Client client) async {
  final response = await client.get(
      Uri.parse(
          'https://webapps.utrgv.edu/aa/dm/api/CourseInfo/GetCoursesPaginated?pageNumber=1&pageSize=100&term=202310&search=&college=Engineering%20and%20Computer%20Scien&subject=CSCI'),
      headers: {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
      });

  // Use the compute function to run parsePhotos in a separate isolate.
  return parseCourseData(response.body);
}

//Calendar Block with Custom Text
Widget calendarBlock(String text) {
  return (Container(
      width: 150,
      height: 75,
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: Text(
        text,
        textAlign: TextAlign.center,
      )));
}

//Build Calendar Column
List<Widget> calendarContainer(String day) {
  List<Widget> outList = [];
  switch (day) {
    case "None":
      outList.add(calendarBlock(""));
      for (int i = 0; i <= 24; i++) {
        outList.add(calendarBlock(i.toString() + ":00"));
      }
      return outList;
    case "Mon":
      outList.add(calendarBlock("Monday"));
      for (int i = 0; i <= 24; i++) {
        outList.add(calendarBlock(""));
      }
      return outList;
    case "Tue":
      outList.add(calendarBlock("Tuesday"));
      for (int i = 0; i <= 24; i++) {
        outList.add(calendarBlock(""));
      }
      return outList;
    case "Wed":
      outList.add(calendarBlock("Wednesday"));
      for (int i = 0; i <= 24; i++) {
        outList.add(calendarBlock(""));
      }
      return outList;
    case "Thur":
      outList.add(calendarBlock("Thursday"));
      for (int i = 0; i <= 24; i++) {
        outList.add(calendarBlock(""));
      }
      return outList;
    case "Fri":
      outList.add(calendarBlock("Friday"));
      for (int i = 0; i <= 24; i++) {
        outList.add(calendarBlock(""));
      }
      return outList;
    default:
      outList.add(calendarBlock("None"));
      for (int i = 0; i <= 24; i++) {
        outList.add(calendarBlock(""));
      }
      return outList;
  }
}

/*
 _____  _                             
/  __ \| |                            
| /  \/| |  __ _  ___  ___   ___  ___ 
| |    | | / _` |/ __|/ __| / _ \/ __|
| \__/\| || (_| |\__ \\__ \|  __/\__ \
 \____/|_| \__,_||___/|___/ \___||___/
*/

//Class for Course Data
class CourseData {
  final String subject;
  final String number;
  final String title;

  const CourseData({
    required this.subject,
    required this.number,
    required this.title,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      subject: json['classSubject'] as String,
      number: json['classNumber'] as String,
      title: json['classTitle'] as String,
    );
  }
}

//Classes page, shows the relevant classes.
class Classes extends StatelessWidget {
  const Classes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CourseData>>(
        future: fetchCourseData(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return CourseList(photos: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class CourseList extends StatelessWidget {
  const CourseList({super.key, required this.photos});

  final List<CourseData> photos;
//ListView(padding: const EdgeInsets.all(8),
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.computer),
          title: Text(photos[index].subject + " " + photos[index].number),
          subtitle: Text(photos[index].title),
        );
      },
    );
  }
}

//Schedule of classes, currently empty.
class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(20.0),
            children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(children: calendarContainer("None")), //Hours
            Column(children: calendarContainer("Mon")), //Monday
            Column(children: calendarContainer("Tue")), //Tuesday
            Column(children: calendarContainer("Wed")), //Wednesday
            Column(children: calendarContainer("Thur")), //Thursday
            Column(children: calendarContainer("Fri")),
          ]) //Friday
        ]));
  }
}

//Index, will show currently logged in student.
//Currently shows placeholder.
//Will pull student info from internal Possibilico API
class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: FittedBox(
                fit: BoxFit.fill,
                child: Container(
                    color: Colors.lightGreen,
                    child: Column(children: [
                      Image.network(
                          'https://st3.depositphotos.com/6672868/13701/v/600/depositphotos_137014128-stock-illustration-user-profile-icon.jpg',
                          scale: 1.5),
                      const Text(
                        "First, Last",
                        textScaleFactor: 2.0,
                      ),
                      const Text("Graduation Year: 2024"),
                      const Text("Major: Computer Science"),
                    ])))));
  }
}

//Home Page with Selector for Index, Classes or Schedule
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var pageIndex = 0;

  var pages = [
    const Index(),
    const Classes(),
    const Schedule(),
  ];
  void onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF05023),
        title: const Text("Possibilico - UTRGV"),
      ),
      body: pages.elementAt(pageIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Classes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Schedule',
          ),
        ],
        currentIndex: pageIndex,
        onTap: onItemTapped,
      ),
    ));
  }
}

//Firebase Auth
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().userChanges(),
      initialData: AuthService().currentUser(),
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
