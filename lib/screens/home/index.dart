import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('utrgv-blur.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(children: [
        Row(children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                      'https://nntheblog2.b-cdn.net/wp-content/uploads/2022/02/Pochita-chainsaw-man-8.jpg'),
                  fit: BoxFit.fill),
            ),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
              child: Text("First Last", style: headerStyle)),
        ]),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          width: double.infinity,
          color: Colors.black,
          child: Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text("Course Progression",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white))),
        )
      ])));
}

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return (CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(child: Container(child: Header())),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Center(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.computer),
                        title: Text("CSCI 1102"),
                        subtitle: Text('Introduction to Computer Science.'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}
