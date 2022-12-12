import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'package:possibilico/screens/home/sharedData&Fun.dart';

String decodeSemesterCode(String input) {
  if (input.length > 6) {
    return input;
  } else {
    String year = input.substring(0, 4);
    String sem = input.substring(4);
    switch (sem) {
      case "10":
        year = (int.parse(year) - 1).toString();
        return "Fall " + year;
      case "20":
        return "Spring " + year;
      case "30":
        return "Summer I " + year;
      case "40":
        return "Summer II " + year;
      default:
        break;
    }
    return input;
  }
}

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
Future<List<CourseData>> fetchCourseData(
    http.Client client, String subject, String semester) async {
  int intSem = int.parse(semester);
  var finResponse;
  var response = await client
      .get(Uri.parse(compileJSONRequest(1, subject, intSem)), headers: {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*",
  });
  print(compileJSONRequest(1, subject, intSem));
  finResponse = jsonDecode(response.body)['data']['courseInfos'];
  var totPages = jsonDecode(response.body)['totalPages'];
  for (int i = 2; i <= totPages; i++) {
    response = await client
        .get(Uri.parse(compileJSONRequest(i, subject, intSem)), headers: {
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
  final int taken;
  final int available;

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
    required this.taken,
    required this.available,
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
      taken: json['seatsTaken'] as int,
      available: json['seatsAvail'] as int,
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
  String minString = minutes.toString();
  if (minString == "0") {
    minString = "00";
  }
  if (pastTwelve == false) {
    return hour.toString() + ":" + minString + " AM";
  } else {
    return hour.toString() + ":" + minString + " PM";
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

class getCourseRecs extends StatelessWidget {
  final int semester;
  const getCourseRecs({super.key, required this.semester});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: ExpansionTile(
      leading: getRelevantIcon("CSCI"),
      title: Text(
        "CSCI 3333",
      ),
      children: <Widget>[
        ListTile(
          title: Text(
            "Unlocks Courses:",
            style: TextStyle(),
          ),
        )
      ],
    ));
  }
}

class getClasses extends StatelessWidget {
  final String subject;
  final String semester;
  const getClasses({super.key, required this.subject, required this.semester});

  @override
  Widget build(BuildContext context) {
    var subject;
    return Container(
      child: FutureBuilder<List<CourseData>>(
        future: fetchCourseData(http.Client(), this.subject, this.semester),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            var classDict = {};

            for (var i = 0; i < snapshot.data!.length; i++) {
              var faculty;
              faculty = "Section ";

              faculty += snapshot.data![i].section +
                  " - " +
                  snapshot.data![i].facultyFirstName +
                  " " +
                  snapshot.data![i].facultyLastName +
                  " - CRN:" +
                  snapshot.data![i].crn +
                  "\n";
              if (snapshot.data![i].days != "") {
                faculty += fullHour(snapshot.data![i].start.toString()) +
                    " to " +
                    fullHour(snapshot.data![i].end.toString()) +
                    " - " +
                    fullDays(snapshot.data![i].days) +
                    "\n";
              }
              faculty += snapshot.data![i].campus + "\n";
              faculty += "Seats: " +
                  snapshot.data![i].available.toString() +
                  "/" +
                  (snapshot.data![i].available + snapshot.data![i].taken)
                      .toString() +
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

class CourseSelector extends StatefulWidget {
  const CourseSelector({super.key});

  @override
  State<CourseSelector> createState() => _CourseSelectorState();
}

class _CourseSelectorState extends State<CourseSelector> {
  @override
  // Initial Selected Value
  String dropdownvalue = 'ACCT';
  String semestervalue = "202310";

  // List of items in our dropdown menu
  var items = [
    'ACCT',
    'ANTH',
    'ARAB',
    'ARTS',
    'ASLI',
    'ASTR',
    'BADM',
    'BILC',
    'BIOL',
    'BLAW',
    'BMED',
    'CESL',
    'CHEM',
    'CHIN',
    'CIVE',
    'CLAS',
    'CLSC',
    'COMD',
    'COMM',
    'COUN',
    'CRIJ',
    'CSCI',
    'CSHR',
    'CYBI',
    'DANC',
    'DIET',
    'ECED',
    'ECON',
    'EDBE',
    'EDCI',
    'EDFR',
    'EDRE',
    'EDSL',
    'EDTC',
    'EDUC',
    'EDUL',
    'EECE',
    'EEMS',
    'ELEE',
    'ENGL',
    'ENGT',
    'ENST',
    'ENTR',
    'ENVR',
    'EPSY',
    'EXAR',
    'FILM',
    'FINA',
    'FREN',
    'GEOG',
    'GEOL',
    'GERM',
    'GRAD',
    'GSCM',
    'GSST',
    'GWSP',
    'HGEN',
    'HIST',
    'HLTH',
    'HONR',
    'HOST',
    'HPRS',
    'HRPT',
    'INDS',
    'INFS',
    'INTB',
    'INTM',
    'KINE',
    'KORN',
    'LDST',
    'MANE',
    'MARK',
    'MARS',
    'MASC',
    'MATE',
    'MATH',
    'MECE',
    'MGMT',
    'MUAP',
    'MUEN',
    'MUSI',
    'NURS',
    'NUTR',
    'OCCT',
    'OTDE',
    'PAFF',
    'PHAS',
    'PHIL',
    'PHYS',
    'POLS',
    'PSCI',
    'PSYC',
    'QUMT',
    'READ',
    'REHS',
    'RELS',
    'RLIT',
    'ROTC',
    'SAFS',
    'SOCI',
    'SOCW',
    'SPAN',
    'SPED',
    'STAT',
    'THTF',
    'TRSP',
    'UNIV',
    'UTCH',
    'WRLS'
  ];

  var items2 = [
    "201810",
    "201820",
    "201830",
    "201910",
    "201920",
    "201930",
    "202010",
    "202020",
    "202030",
    "202110",
    "202120",
    "202130",
    "202210",
    "202220",
    "202230",
    "202310",
    "202320",
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        const SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.only(top: 50),
        )),
        //getCourseRecs(semester: int.parse(semestervalue)),
        SliverToBoxAdapter(
            child: Container(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
          child: Row(children: [
            DropdownButton(
              value: dropdownvalue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
            const Spacer(),
            DropdownButton(
              value: semestervalue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items2.map((String items2) {
                return DropdownMenuItem(
                  value: items2,
                  child: Text(decodeSemesterCode(items2)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  semestervalue = newValue!;
                });
              },
            )
          ]),
        )),
        SliverToBoxAdapter(
            child: Card(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Text(
              "${decodeSemesterCode(semestervalue)} - Full Course List",
              style: const TextStyle(fontSize: 18),
            ),
          ),
        )),
        SliverToBoxAdapter(
            child: getClasses(
                key: UniqueKey(),
                subject: dropdownvalue,
                semester: semestervalue)),
      ]),
    );
  }
}

Widget _buildExpandableTile(key, value) {
  return ExpansionTile(
    leading: getRelevantIcon(key.substring(0, 4)),
    title: Text(
      key,
    ),
    trailing: const Checkbox(
      checkColor: Colors.white,
      value: false,
      onChanged: null,
    ),
    children: <Widget>[
      ListTile(
        title: Text(
          value,
          style: TextStyle(),
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
    return Container(
        child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: photos.keys.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildExpandableTile(keysList[index], valuesList[index]);
      },
    ));
  }
}
