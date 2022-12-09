import 'package:flutter/material.dart';
import 'package:possibilico/screens/home/index.dart';
import 'package:possibilico/screens/home/degree_tree.dart';
import 'package:possibilico/screens/home/schedule.dart';
import 'package:possibilico/screens/home/course_list.dart';
import 'package:possibilico/services/auth.dart';

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
    Classes(subject: "ACCT"),
    Schedule(),
    const DegreeTree(),
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
        title: const Text("Possibilico: A Degree-Planning Smart Application"),
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
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.account_tree),
            label: 'Progress',
          ),
        ],
        currentIndex: pageIndex,
        onTap: onItemTapped,
      ),
    ));
  }
}
