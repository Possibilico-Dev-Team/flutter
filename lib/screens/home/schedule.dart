import 'package:flutter/material.dart';
import 'package:time_planner/time_planner.dart';
import 'dart:math';

class Schedule extends StatefulWidget {
  Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  List<TimePlannerTask> tasks = [];

  void _addObject(BuildContext context) {
    List<Color?> colors = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.cyan
    ];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var taskInput = [
      {
        'day': 1,
        'hour': 15,
        'minutes': 30,
        'text': "Top CSCI: Robotics Programming"
      },
      {'day': 1, 'hour': 17, 'minutes': 0, 'text': "Senior Project"},
      {
        'day': 2,
        'hour': 9,
        'minutes': 30,
        'text': "Top CSCI: Technical Interview"
      },
      {
        'day': 2,
        'hour': 11,
        'minutes': 00,
        'text': "Automata Formal Lang and Comp"
      },
      {
        'day': 2,
        'hour': 14,
        'minutes': 00,
        'text': "Algorithms and Data Structures"
      },
      {
        'day': 3,
        'hour': 15,
        'minutes': 30,
        'text': "Top CSCI: Robotics Programming"
      },
      {'day': 3, 'hour': 17, 'minutes': 0, 'text': "Senior Project"},
      {
        'day': 4,
        'hour': 9,
        'minutes': 30,
        'text': "Top CSCI: Technical Interview"
      },
      {
        'day': 4,
        'hour': 11,
        'minutes': 00,
        'text': "Automata Formal Lang and Comp"
      },
      {
        'day': 4,
        'hour': 14,
        'minutes': 00,
        'text': "Algorithms and Data Structures"
      },
    ];

    for (var i in taskInput) {
      tasks.add(TimePlannerTask(
        onTap: () {},
        color: Colors.orange,
        dateTime: TimePlannerDateTime(
            day: int.parse(i['day'].toString()),
            hour: int.parse(i['hour'].toString()),
            minutes: int.parse(i['minutes'].toString())),
        minutesDuration: 45,
        daysDuration: 1,
        child: Text(
          (i['text'].toString()),
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ));
    }

    return Scaffold(
        body: TimePlanner(
            startHour: 6,
            endHour: 20,
            headers: [
              TimePlannerTitle(
                date: "",
                title: "Monday",
              ),
              TimePlannerTitle(
                date: "",
                title: "Tuesday",
              ),
              TimePlannerTitle(
                date: "",
                title: "Wednesday",
              ),
              TimePlannerTitle(
                date: "",
                title: "Thursday",
              ),
              TimePlannerTitle(
                date: "",
                title: "Friday",
              ),
              TimePlannerTitle(
                date: "",
                title: "Saturday",
              ),
              TimePlannerTitle(
                date: "",
                title: "Sunday",
              ),
            ],
            tasks: tasks,
            currentTimeAnimation: false,
            style: TimePlannerStyle(showScrollBar: false)));
  }
}
