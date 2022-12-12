import 'package:flutter/material.dart';

Icon getRelevantIcon(String input) {
  Map iconDict = {
    "CSCI": Icons.computer,
    "ACCT": Icons.account_balance,
    "ECON": Icons.monetization_on_rounded,
    "ELEE": Icons.electrical_services,
    "HONR": Icons.school,
    "MATH": Icons.calculate,
    "PHIL": Icons.book,
    "POLS": Icons.festival,
    "HIST": Icons.festival,
    "CHEM": Icons.science,
    "MARK": Icons.feed,
    "PHYS": Icons.science,
    "COMM": Icons.mic_outlined,
    "ARTS": Icons.draw,
    "STAT": Icons.calculate,
    "ENGL": Icons.book,
  };
  if (iconDict[input] == null) {
    return Icon(Icons.school);
  } else {
    return Icon(iconDict[input]);
  }
}
