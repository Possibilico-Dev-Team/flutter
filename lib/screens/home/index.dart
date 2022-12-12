import 'package:flutter/material.dart';
import 'package:possibilico/screens/home/sharedData&Fun.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

Map finishedCourses = {
  '201910': [
    'CSCI 1380',
    'ECON 1301',
    'ELEE 1101',
    'HONR 2387',
    'MATH 1314',
    'PHIL 2326'
  ],
  '201920': ['ELEE 2130', 'HONR 2388', 'MATH 2412', 'POLS 2305', 'THTF 2366'],
  '202010': [
    'CSCI 1101',
    'CSCI 1170',
    'CSCI 1370',
    'ELEE 2330',
    'HIST 1302',
    'POLS 2306'
  ],
  '202020': ['CHEM 1309', 'CSCI 2380', 'MARK 3300', 'MATH 2413'],
  '202040': ['CSCI 3326'],
  '202110': ['MATH 2346', 'PHYS 2425'],
  '202120': ['COMM 1315', 'CSCI 2333', 'CSCI 2344', 'CSCI 3340'],
  '202140': ['CSCI 3310'],
  '202240': ['CSCI 4345'],
  '202210': ['ARTS 4336', 'CSCI 3336', 'MATH 2318', 'MATH 2414'],
  '202220': ['CSCI 3333', 'CSCI 3342', 'CSCI 4335', 'ENGL 3342', 'STAT 3301']
};

final ScrollController myScrollWorks = ScrollController();

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}

final items = List<ListItem>.generate(
  10,
  (i) => i % 6 == 0
      ? HeadingItem('Heading $i')
      : MessageItem('Sender $i', 'Message body $i'),
);

Widget ListFinal() {
  return (ListView.builder(
    // Let the ListView know how many items it needs to build.
    itemCount: items.length,
    // Provide a builder function. This is where the magic happens.
    // Convert each item into a widget based on the type of item it is.
    itemBuilder: (context, index) {
      final item = items[index];

      return ListTile(
        title: item.buildTitle(context),
        subtitle: item.buildSubtitle(context),
      );
    },
  ));
}

const headerStyle = TextStyle(
    color: Colors.white,
    fontSize: 50,
    shadows: <Shadow>[
      Shadow(
        blurRadius: 4.0,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    ],
    fontStyle: FontStyle.italic);

Widget Header() {
  return (Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/utrgv-blur.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(children: [
        Row(children: [
          Container(
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                      'https://as2.ftcdn.net/v2/jpg/00/64/67/63/1000_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'),
                  fit: BoxFit.fill),
            ),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
              child: Text("Juan Smith", style: headerStyle)),
        ]),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          width: double.infinity,
          color: Colors.black,
          child: Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: const Text("Course Progression",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white))),
        )
      ])));
}

@override
Widget build(BuildContext context) {
  return Scaffold(
      body: Center(
          child: Container(
              child: SfSparkLineChart(
    //Enable the trackball
    trackball:
        SparkChartTrackball(activationMode: SparkChartActivationMode.tap),
    //Enable marker
    marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
    //Enable data label
    labelDisplayMode: SparkChartLabelDisplayMode.all,
    data: <double>[1, 5, -6, 0, 1, -2, 7, -7, -4, -10, 13, -6, 7, 5, 11, 5, 3],
  ))));
}

SliverToBoxAdapter cardSliver(input) {
  return SliverToBoxAdapter(
      child: Card(
    child: Text(decodeSemesterCode(input)),
  ));
}

SliverToBoxAdapter classCard(input) {
  return (SliverToBoxAdapter(
      child: Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: getRelevantIcon(input.substring(0, 4)),
          title: Text(input),
          subtitle: Text(''),
        ),
      ],
    ),
  )));
}

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

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    var sliverCardList = <Widget>[];
    sliverCardList.add(SliverToBoxAdapter(child: Container(child: Header())));
    for (var prop in finishedCourses.keys) {
      sliverCardList.add(cardSliver(prop));

      for (var prop2 in finishedCourses[prop]) {
        sliverCardList.add(classCard(prop2));
      }
      ;
    }
    return (PrimaryScrollController(
        controller: myScrollWorks,
        child: CustomScrollView(
          slivers: sliverCardList,
        )));
  }
}
