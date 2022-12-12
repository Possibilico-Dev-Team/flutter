import 'dart:core';
import 'package:flutter/material.dart';
import 'package:graphite/core/matrix.dart';
import 'package:graphite/graphite.dart';

const presetBasic2 =
    '[{"id":"CSCI 1101","next":["CSCI 1370"]},{"id":"CSCI 1370","next":["CSCI 3310","CSCI 2333","CSCI 2380"]},{"id":"CSCI 3310","next":["CSCI 2344"]},{"id":"CSCI 2333","next":["J"]},{"id":"CSCI 2380","next":["J"]},{"id":"J","next":["I"]},{"id":"I","next":["H"]},{"id":"CSCI 2344","next":["K"]},{"id":"K","next":["L"]},{"id":"H","next":["L"]},{"id":"L","next":["P"]},{"id":"P","next":["M","N"]},{"id":"M","next":[]},{"id":"N","next":[]}]';

const presetBasic = '[{"id":"A","next":["B"]},{"id":"B","next":["C","D","E"]},'
    '{"id":"C","next":["F"]},{"id":"D","next":["J"]},{"id":"E","next":["J"]},'
    '{"id":"J","next":["I"]},{"id":"I","next":["H"]},{"id":"F","next":["K"]},'
    '{"id":"K","next":["L"]},{"id":"H","next":["L"]},{"id":"L","next":["P"]},'
    '{"id":"P","next":["M","N"]},{"id":"M","next":[]},{"id":"N","next":[]}]';

class DegreeTree extends StatefulWidget {
  DegreeTree({Key? key}) : super(key: key);
  @override
  _DegreeTreeState createState() => _DegreeTreeState();
}

class _DegreeTreeState extends State<DegreeTree> {
  @override
  Widget build(BuildContext context) {
    var list = nodeInputFromJson(presetBasic);
    return Scaffold(
      body: DirectGraph(
        list: list,
        cellWidth: 136.0,
        cellPadding: 24.0,
        orientation: MatrixOrientation.Horizontal,
      ),
    );
  }
}
