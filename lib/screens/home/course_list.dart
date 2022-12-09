import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    return Column(children: [
      ListView.builder(
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.computer),
            title: Text("${photos[index].subject} ${photos[index].number}"),
            subtitle: Text(photos[index].title),
          );
        },
      )
    ]);
  }
}
