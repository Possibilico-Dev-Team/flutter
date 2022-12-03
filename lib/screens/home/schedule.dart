import 'package:flutter/material.dart';

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
        outList.add(calendarBlock("$i:00"));
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

//Schedule of classes, currently empty.
class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(children: calendarContainer("None")), //Hours
            Column(children: calendarContainer("Mon")), //Monday
            Column(children: calendarContainer("Tue")), //Tuesday
            Column(children: calendarContainer("Wed")), //Wednesday
            Column(children: calendarContainer("Thur")), //Thursday
            Column(children: calendarContainer("Fri")), //Friday
          ]),
        ]),
      ),
    );
  }
}
