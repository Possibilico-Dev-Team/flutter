import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String compileJSONRequest(pageNum, subject, term) {
  var finResponse;
  var request =
      'https://webapps.utrgv.edu/aa/dm/api/CourseInfo/GetCoursesPaginated?pageNumber=' +
          pageNum.toString() +
          '&pageSize=20&term=' +
          term.toString() +
          '&search=&college=&subject=' +
          subject;
  return request;
}

//Requests JSON Data from UTRGV Servers
Future<List<CourseData>> fetchCourseData(http.Client client) async {
  var finResponse;
  var response = await client
      .get(Uri.parse(compileJSONRequest(1, "ENGL", 202310)), headers: {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*",
  });
  finResponse = jsonDecode(response.body)['data']['courseInfos'];
  var totPages = jsonDecode(response.body)['totalPages'];
  for (int i = 2; i <= totPages; i++) {
    response = await client
        .get(Uri.parse(compileJSONRequest(i, "ENGL", 202310)), headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    });
    finResponse += jsonDecode(response.body)['data']['courseInfos'];
  }
  // Use the compute function to run parsePhotos in a separate isolate.
  return finResponse
      .map<CourseData>((json) => CourseData.fromJson(json))
      .toList();
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
  final String facultyFirstName;
  final String facultyLastName;
  final String section;
  final String start;
  final String end;
  final String days;
  final String crn;
  final int creditHours;
  final String campus;

  const CourseData({
    required this.subject,
    required this.number,
    required this.title,
    required this.facultyFirstName,
    required this.facultyLastName,
    required this.section,
    required this.start,
    required this.end,
    required this.days,
    required this.crn,
    required this.creditHours,
    required this.campus,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      subject: json['classSubject'] as String,
      number: json['classNumber'] as String,
      title: json['classTitle'] as String,
      facultyFirstName: json['facultyFirstName'] as String,
      facultyLastName: json['facultyLastName'] as String,
      section: json['classSection'] as String,
      start: json['meet1Starts'] as String,
      end: json['meet1Ends'] as String,
      days: json['meet1Days'] as String,
      crn: json['classCrn'] as String,
      creditHours: json['creditHrs'] as int,
      campus: json['campDesc'] as String,
    );
  }
}

String fullHour(input) {
  if (input == "") {
    return "";
  }
  bool pastTwelve = false;
  var hour = int.parse(input.substring(0, 2));
  var minutes = int.parse(input.substring(2, 4));
  if (hour > 12) {
    hour -= 12;
    pastTwelve = true;
  }
  if (pastTwelve == false) {
    return hour.toString() + ":" + minutes.toString() + " AM";
  } else {
    return hour.toString() + ":" + minutes.toString() + " PM";
  }
}

String fullDays(input) {
  switch (input) {
    case "MW":
      return "Monday/Wednesday";
    case "TR":
      return "Tuesday/Thursday";
    case "F":
      return "Friday";
    default:
      return "";
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
          print(snapshot);
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            var classDict = {};

            for (var i = 0; i < snapshot.data!.length; i++) {
              var faculty = "Section " +
                  snapshot.data![i].section +
                  " - " +
                  snapshot.data![i].facultyFirstName +
                  " " +
                  snapshot.data![i].facultyLastName +
                  " - CRN:" +
                  snapshot.data![i].crn +
                  "\n" +
                  fullHour(snapshot.data![i].start.toString()) +
                  " to " +
                  fullHour(snapshot.data![i].end.toString()) +
                  " - " +
                  fullDays(snapshot.data![i].days) +
                  "\n" +
                  snapshot.data![i].campus +
                  "\n";

              var combined = snapshot.data![i].subject +
                  " " +
                  snapshot.data![i].number +
                  " - " +
                  snapshot.data![i].title +
                  "\nCredit Hours: " +
                  snapshot.data![i].creditHours.toString();
              classDict.putIfAbsent(combined, () => []);
              var finList = classDict[combined];
              finList.add(faculty);
              classDict[combined] = finList;
            }

            return CourseList(photos: classDict);
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

Widget _buildExpandableTile(key, value) {
  return ExpansionTile(
    title: Text(
      key,
    ),
    children: <Widget>[
      ListTile(
        title: Text(
          value,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      )
    ],
  );
}

class CourseList extends StatelessWidget {
  const CourseList({super.key, required this.photos});

  final Map photos;
//ListView(padding: const EdgeInsets.all(8),

  @override
  Widget build(BuildContext context) {
    var keysList = [];
    var valuesList = [];
    for (var element in photos.keys) {
      keysList.add(element);
      var finOut = "";
      for (var j in photos[element]) {
        finOut += j + "\n";
      }
      valuesList.add(finOut);
    }
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: photos.keys.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildExpandableTile(keysList[index], valuesList[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
