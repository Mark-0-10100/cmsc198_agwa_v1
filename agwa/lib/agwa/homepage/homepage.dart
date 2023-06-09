import 'package:agwa/agwa/addSensor/addSensorPage.dart';
import 'package:agwa/screens/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../inventory/inventory_options.dart';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  // Query dbRef = FirebaseDatabase.instance.ref();

  // DatabaseReference reference = FirebaseDatabase.instance.ref();
  final reference = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL:
              'https://agwa-trial-space-v1-default-rtdb.asia-southeast1.firebasedatabase.app/')
      .ref('pHValue');

  Widget listItem({required Map phVal}) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 110,
        color: Colors.amberAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current pH Level: 7",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    // reference
    //     .set(
    //       'beltt',
    //     )
    //     .then((value) => print('belt is setting'));
    // rtdb.onValue.listen((DatabaseEvent event) {
    //   final data = event.snapshot.value;
    //   print(data);
    // });

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 24),
          Center(
            child: Stack(children: [
              Container(
                // child: FirebaseAnimatedList(
                //   query: dbRef,
                //   itemBuilder: (BuildContext context, DataSnapshot snapshot,
                //       Animation<double> animation, int index) {
                //     Map phVal = snapshot.value as Map;
                //     phVal['key'] = snapshot.key;
                //     //return listItem(phVal: phVal);
                //     return Text("Current pH Level: 7");
                //   },
                // ),
                child: StreamBuilder(
                  stream: reference.onValue,
                  builder: (BuildContext context,
                      AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.hasData) {
                      // Process the retrieved data
                      DataSnapshot data = snapshot.data!.snapshot;

                      // Use the data to populate your UI
                      return Text(data.value.toString());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                    // return Text('some text');
                  },
                ),
                //

                color: Colors.cyan,
                width: 320,
                padding: EdgeInsets.symmetric(vertical: 100.0),
              ),
            ]),
          ),
          SizedBox(height: 24),
          Container(child: Text("Reminders ss"), width: 360),
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
    // bottomNavigationBar: BottomNavigationBar(
    //   currentIndex: currentIndex,
    //   onTap: (index) => setState(() => currentIndex = index),
    //   items: const [
    //     BottomNavigationBarItem(
    //         label: "Sensor",
    //         icon: Icon(Icons.signal_cellular_0_bar_outlined)),
    //     BottomNavigationBarItem(
    //       label: "Home",
    //       icon: Icon(Icons.home),
    //     ),
    //     BottomNavigationBarItem(
    //       label: 'Settings',
    //       icon: Icon(Icons.settings),
    //     )
    //   ],
    // ));
  }
}
