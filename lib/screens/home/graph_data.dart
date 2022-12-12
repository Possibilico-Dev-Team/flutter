import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'package:possibilico/screens/home/sharedData&Fun.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'dart:async';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GraphData extends StatefulWidget {
  GraphData({Key? key}) : super(key: key);

  @override
  _GraphDataState createState() => _GraphDataState();
}

class _GraphDataState extends State<GraphData> {
  //@override
  // Widget build(BuildContext context) {
  //return Scaffold(body: Center(child: Container(child: SfCartesianChart())));
  List<_SalesData> data = [
    _SalesData('FALL 2020', 18),
    _SalesData('SPRING 2021', 17),
    _SalesData('SUM1 2021', 3),
    _SalesData('SUM2 2021', 3),
    _SalesData('FALL 2021', 12),
    _SalesData('SPRING 2022', 15),
    _SalesData('SUM1 2022', 6),
    _SalesData('SUM2 2022', 0),
    _SalesData('FALL 2022', 14)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Data Report'),
        ),
        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Credit Enrollment Hours'),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                    dataSource: data,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: 'Hours',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]),
          Container(
            color: Colors.black,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),

          Padding(
            //SPACER
            padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
            child: Text(
              '',
              style: TextStyle(color: Colors.white),
            ),
          ),

          Row /*or Column*/ (
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(Icons.query_stats_rounded, size: 50),
              Icon(Icons.refresh_rounded, size: 50),
              Icon(Icons.pending_actions_rounded, size: 50),
              Icon(Icons.person_rounded, size: 50),
            ],
          ),
          Padding(
            //SPACER
            padding: const EdgeInsets.only(bottom: 15.0, top: 5.0),
            child: Text(
              '',
              style: TextStyle(color: Colors.white),
            ),
          ),

          Row(
            children: <Widget>[
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    //Initialize the spark charts widget
                    /*  child: SfLinearGauge(
                  minimum: 0.0,
                  maximum: 100.0,
                  orientation: LinearGaugeOrientation.horizontal,
                  majorTickStyle: LinearTickStyle(length: 20),
                  axisLabelStyle:
                      TextStyle(fontSize: 12.0, color: Colors.black),
                  axisTrackStyle: LinearAxisTrackStyle(
                      color: Colors.cyan,
                      edgeStyle: LinearEdgeStyle.bothFlat,
                      thickness: 15.0,
                      borderColor: Colors.grey)), */

                    child: SfRadialGauge(axes: <RadialAxis>[
                      RadialAxis(minimum: 0, maximum: 148, ranges: <GaugeRange>[
                        GaugeRange(
                            startValue: 0,
                            endValue: 37,
                            color: Color(0xFFF44336)), //0xFFF44336
                        GaugeRange(
                            startValue: 37,
                            endValue: 111,
                            color: Color(0xFFFF9800)),
                        GaugeRange(
                            startValue: 111,
                            endValue: 148,
                            color: Color(0xFF4CAF50))
                      ], pointers: <GaugePointer>[
                        NeedlePointer(value: 88)
                      ], annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                            widget: Container(
                                child: Text('88 Hours',
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold))),
                            angle: 90,
                            positionFactor: .66)
                      ])
                    ])),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Degree in Bachelor of Computer Science',
                            style: TextStyle(
                                color: Color.fromARGB(255, 31, 30, 30),
                                fontWeight: FontWeight.bold,
                                fontSize: 32)),
                      ),
                      Container(
                        color: Color.fromARGB(62, 0, 0, 0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 2),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 18),
                        child: Text('General Education Core',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 24)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, left: 55.0),
                        child: Text('22 Credit Hours Needed',
                            style: TextStyle(
                                color: Color.fromARGB(255, 158, 14, 14),
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: SfLinearGauge(
                            minimum: 0.0,
                            maximum: 42.0,
                            orientation: LinearGaugeOrientation.horizontal,
                            majorTickStyle: LinearTickStyle(length: 6),
                            axisLabelStyle:
                                TextStyle(fontSize: 12.0, color: Colors.black),
                            axisTrackStyle: LinearAxisTrackStyle(
                                color: Colors.cyan,
                                edgeStyle: LinearEdgeStyle.bothFlat,
                                thickness: 15.0,
                                borderColor: Colors.grey)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: Text('Major in Computer Science',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 24)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, left: 55.0),
                        child: Text('63 Credit Hours Needed',
                            style: TextStyle(
                                color: Color.fromARGB(255, 158, 14, 14),
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: SfLinearGauge(
                            minimum: 0.0,
                            maximum: 72.0,
                            orientation: LinearGaugeOrientation.horizontal,
                            majorTickStyle: LinearTickStyle(length: 6),
                            axisLabelStyle:
                                TextStyle(fontSize: 12.0, color: Colors.black),
                            axisTrackStyle: LinearAxisTrackStyle(
                                color: Colors.cyan,
                                edgeStyle: LinearEdgeStyle.bothFlat,
                                thickness: 15.0,
                                borderColor: Colors.grey)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Minor in Graphic Design',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 24)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, left: 55.0),
                        child: Text('12 Credit Hours Needed',
                            style: TextStyle(
                                color: Color.fromARGB(255, 158, 14, 14),
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: SfLinearGauge(
                            minimum: 0.0,
                            maximum: 16.0,
                            orientation: LinearGaugeOrientation.horizontal,
                            majorTickStyle: LinearTickStyle(length: 6),
                            axisLabelStyle:
                                TextStyle(fontSize: 12.0, color: Colors.black),
                            axisTrackStyle: LinearAxisTrackStyle(
                                color: Colors.cyan,
                                edgeStyle: LinearEdgeStyle.bothFlat,
                                thickness: 15.0,
                                borderColor: Colors.grey)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            //SPACER
            padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
            child: Text(
              '',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            color: Colors.black,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),

          Padding(
            //SPACER
            padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
            child: Text(
              '',
              style: TextStyle(color: Colors.white),
            ),
          ),

          Row /*or Column*/ (
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Adjust",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 155, 38, 34)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Reset",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ]));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
