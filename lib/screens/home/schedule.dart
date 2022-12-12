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

    setState(() {
      tasks.add(
        TimePlannerTask(
          onTap: () {},
          child: Text(
            'CSCI',
            style: TextStyle(color: Colors.grey[350], fontSize: 12),
          ),
          color: colors[Random().nextInt(colors.length)],
          dateTime: TimePlannerDateTime(
              day: Random().nextInt(10),
              hour: Random().nextInt(14) + 6,
              minutes: Random().nextInt(60)),
          minutesDuration: Random().nextInt(90) + 30,
          daysDuration: Random().nextInt(4) + 1,
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Random task added to time planner!')));
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < 6; i++) {
      tasks.add(TimePlannerTask(
        color: Colors.orange,
        dateTime: TimePlannerDateTime(
            day: Random().nextInt(10),
            hour: Random().nextInt(14) + 6,
            minutes: Random().nextInt(60)),
        minutesDuration: 45,
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
            style: TimePlannerStyle(showScrollBar: false)));
  }
}
