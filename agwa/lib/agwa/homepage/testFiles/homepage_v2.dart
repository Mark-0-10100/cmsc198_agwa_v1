// For displaying the line chart
// needed package for graph: syncfusion_flutter_charts
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:agwa/models/sensor_reading.dart';
import 'package:agwa/style/app_style.dart';
import 'package:agwa/agwa/addSensor/addSensorPage.dart';
import 'package:agwa/screens/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../inventory/inventory_options.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late List<ChartData> data;

  @override
  void initState(){
    super.initState();
    //dummy data
    data = [
      ChartData(17, 21500),
      ChartData(18, 22684),
      ChartData(19, 21643),
      ChartData(20, 22997),
      ChartData(21, 22883),
      ChartData(22, 22635),
      ChartData(23, 21800),
      ChartData(24, 22997),
      ChartData(25, 22883),
      ChartData(26, 22635),
      ChartData(27, 21800),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.bg_color,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "PH Readings",
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          // SizedBox(height: 10),
          // CircleAvatar(
          //     backgroundImage: Image.asset('images/logo_agwa.png',),
          // )
          // adding line chart
          Center(
            child: SfCartesianChart(
              margin: EdgeInsets.all(0),
              borderWidth: 0,
              borderColor: Colors.transparent,
            )
          ),
          SizedBox(height: 24),
          Container(child: Text("Reminders"), width: 360),
          SizedBox(height: 24),
          Center(
            child: Stack(children: [
              Container(
                child: Text(
                  "Reminders...",
                  textAlign: TextAlign.center,
                ),
                color: Colors.cyan,
                width: 320,
                padding: EdgeInsets.symmetric(vertical: 150.0),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}