import 'package:flutter/material.dart';
import 'package:possibilico/screens/home/schedule.dart';
import 'package:possibilico/screens/home/course_list.dart';
import 'package:possibilico/services/auth.dart';

//Index, will show currently logged in student.
//Currently shows placeholder.
//Will pull student info from internal Possibilico API
class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
                ]))));
  }
}

//Home Page with Selector for Index, Classes or Schedule
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
        actions: [
          TextButton(
              onPressed: () {
                AuthService().signOut();
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ))
        ],
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
