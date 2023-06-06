import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:developer';

//for real time database
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:agwa/models/sensor_reading.dart';
import 'package:agwa/style/app_style.dart';
import 'package:agwa/agwa/addSensor/addSensorPage.dart';
import 'package:agwa/screens/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../inventory/inventory_options.dart';

class homePage extends StatefulWidget {
  // const homePage({super.key});
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  // late DatabaseReference _sensorDataRef;
  // List<SensorReading> _sensorReadings = [];
  // int data = 0;
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  @override
  void initState(){
    super.initState();
    databaseReference.onValue.listen((DatabaseEvent event){
      final data = event.snapshot.value;
      updateStarCount(data);
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Center(
        child: Text(data.value.toString(), style: TextStyle(fontSize: 20),
      );
    ));
  }
}















// DLEAMNOR'S CODE
// For displaying the line chart
// needed package for graph: syncfusion_flutter_charts
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';
// import 'package:agwa/models/sensor_reading.dart';
// import 'package:agwa/style/app_style.dart';
// import 'package:agwa/agwa/addSensor/addSensorPage.dart';
// import 'package:agwa/screens/home/home.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import '../inventory/inventory_options.dart';
//
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
//
// class homePage extends StatefulWidget {
//   const homePage({super.key});
//
//   @override
//   State<homePage> createState() => _homePageState();
// }
//
// class _homePageState extends State<homePage> {
//   late List<ChartData> data;
//
//   @override
//   void initState(){
//     super.initState();
//     //dummy data
//     data = [
//       ChartData(17, 21500),
//       ChartData(18, 22684),
//       ChartData(19, 21643),
//       ChartData(20, 22997),
//       ChartData(21, 22883),
//       ChartData(22, 22635),
//       ChartData(23, 21800),
//       ChartData(24, 22997),
//       ChartData(25, 22883),
//       ChartData(26, 22635),
//       ChartData(27, 21800),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(height: 20),
//           Text(
//             "pH Readings",
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 20),
//           // adding line chart
//           Center(
//               child: SfCartesianChart(
//                 margin: EdgeInsets.all(0),
//                 borderWidth: 0,
//                 borderColor: Colors.transparent,
//                 plotAreaBorderWidth: 0,
//                 primaryXAxis: NumericAxis(
//                   minimum: 17, //let's take the minimum value of our list
//                   maximum: 27, //let's take the maximum value of our list
//                   isVisible: false,
//                   interval: 1,
//                   borderColor: Colors.transparent),
//                   series: <ChartSeries<ChartData, int>>[
//                     SplineAreaSeries(
//                       dataSource: data,
//                       xValueMapper: (ChartData data, _)=> data.time,
//                       yValueMapper: (ChartData data, _)=> data.pH_value,
//                       gradient: LinearGradient(colors: [
//                         AppStyle.spline_color,
//                         AppStyle.spline_color.withAlpha(150),
//                       ])
//                     )
//                   ],
//                 primaryYAxis: NumericAxis(
//                   minimum: 19000,
//                   maximum: 23000,
//                   interval: 1000,
//                   isVisible: false,
//                   borderWidth: 0,
//                   borderColor: Colors.transparent,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

//////// MARK's CODE
// import 'package:agwa/agwa/addSensor/addSensorPage.dart';
// import 'package:agwa/screens/home/home.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import '../inventory/inventory_options.dart';
//
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
//
// class homePage extends StatefulWidget {
//   const homePage({super.key});
//
//   @override
//   State<homePage> createState() => _homePageState();
// }
//
// class _homePageState extends State<homePage> {
//   Query dbRef = FirebaseDatabase.instance.ref();
//   DatabaseReference reference = FirebaseDatabase.instance.ref();
//
//   Widget listItem({required Map phVal}) {
//     return Container(
//         margin: const EdgeInsets.all(10),
//         padding: const EdgeInsets.all(10),
//         height: 110,
//         color: Colors.amberAccent,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Current pH Level: 7",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//             ),
//           ],
//         ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(height: 24),
//           Center(
//             child: Stack(children: [
//               Container(
//                 // child: FirebaseAnimatedList(
//                 //   query: dbRef,
//                 //   itemBuilder: (BuildContext context, DataSnapshot snapshot,
//                 //       Animation<double> animation, int index) {
//                 //     Map phVal = snapshot.value as Map;
//                 //     phVal['key'] = snapshot.key;
//                 //     //return listItem(phVal: phVal);
//                 //     return Text("Current pH Level: 7");
//                 //   },
//                 // ),
//                 child: StreamBuilder(
//                   stream: dbRef.onValue,
//                   builder:
//                       (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//                     if (snapshot.hasData) {
//                       // Process the retrieved data
//                       DataSnapshot data = snapshot.data!.snapshot;
//                       Map<dynamic, dynamic>? dataMap = data.value as Map?;
//                       // Use the data to populate your UI
//                       return Text(dataMap!['phValue']);
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else {
//                       return CircularProgressIndicator();
//                     }
//                   },
//                 ),
//                 //
//
//                 color: Colors.cyan,
//                 width: 320,
//                 padding: EdgeInsets.symmetric(vertical: 100.0),
//               ),
//             ]),
//           ),
//           SizedBox(height: 24),
//           Container(child: Text("Reminders"), width: 360),
//           SizedBox(height: 24),
//           Center(
//             child: Stack(children: [
//               Container(
//                 child: Text(
//                   "Reminders...",
//                   textAlign: TextAlign.center,
//                 ),
//                 color: Colors.cyan,
//                 width: 320,
//                 padding: EdgeInsets.symmetric(vertical: 150.0),
//               ),
//             ]),
//           ),
//         ],
//       ),
//     );
//     // bottomNavigationBar: BottomNavigationBar(
//     //   currentIndex: currentIndex,
//     //   onTap: (index) => setState(() => currentIndex = index),
//     //   items: const [
//     //     BottomNavigationBarItem(
//     //         label: "Sensor",
//     //         icon: Icon(Icons.signal_cellular_0_bar_outlined)),
//     //     BottomNavigationBarItem(
//     //       label: "Home",
//     //       icon: Icon(Icons.home),
//     //     ),
//     //     BottomNavigationBarItem(
//     //       label: 'Settings',
//     //       icon: Icon(Icons.settings),
//     //     )
//     //   ],
//     // ));
//   }
// }
