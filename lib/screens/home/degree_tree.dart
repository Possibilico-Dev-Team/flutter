import 'dart:math';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:graphite/core/matrix.dart';
import 'package:graphite/core/typings.dart';
import 'package:graphite/graphite.dart';
import 'package:possibilico/screens/home/CSFlowchart.dart';

class DegreeTree extends StatefulWidget {
  DegreeTree({Key? key}) : super(key: key);
  @override
  _DegreeTreeState createState() => _DegreeTreeState();
}

class _DegreeTreeState extends State<DegreeTree> {
  @override
  Widget build(BuildContext context) {
    var list = nodeInputFromJson(getCSJSON());
    return Scaffold(
      body: DirectGraph(
        list: list,
        cellWidth: 136.0,
        cellPadding: 24.0,
        orientation: MatrixOrientation.Vertical,
      ),
    );
  }
}
