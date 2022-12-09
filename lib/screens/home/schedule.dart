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
          color: colors[Random().nextInt(colors.length)],
          dateTime: TimePlannerDateTime(
              day: Random().nextInt(10),
              hour: Random().nextInt(14) + 6,
              minutes: Random().nextInt(60)),
          minutesDuration: Random().nextInt(90) + 30,
          daysDuration: Random().nextInt(4) + 1,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('You click on time planner object')));
          },
          child: Text(
            'this is a demo',
            style: TextStyle(color: Colors.grey[350], fontSize: 12),
          ),
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Random task added to time planner!')));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TimePlanner(
            startHour: 2,
            endHour: 24,
            headers: [
              TimePlannerTitle(
                date: "7/20/2021",
                title: "tuesday",
              ),
              TimePlannerTitle(
                date: "7/21/2021",
                title: "wednesday",
              ),
              TimePlannerTitle(
                date: "7/22/2021",
                title: "thursday",
              ),
              TimePlannerTitle(
                date: "7/23/2021",
                title: "friday",
              ),
              TimePlannerTitle(
                date: "7/24/2021",
                title: "saturday",
              ),
              TimePlannerTitle(
                date: "7/25/2021",
                title: "sunday",
              ),
              TimePlannerTitle(
                date: "7/26/2021",
                title: "monday",
              ),
              TimePlannerTitle(
                date: "7/27/2021",
                title: "tuesday",
              ),
              TimePlannerTitle(
                date: "7/28/2021",
                title: "wednesday",
              ),
              TimePlannerTitle(
                date: "7/29/2021",
                title: "thursday",
              ),
              TimePlannerTitle(
                date: "7/30/2021",
                title: "friday",
              ),
              TimePlannerTitle(
                date: "7/31/2021",
                title: "Saturday",
              ),
            ],
            tasks: tasks,
            style: TimePlannerStyle(showScrollBar: true)));
  }
}
