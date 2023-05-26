//This version is the simplest version, the first one you attempted to create

import 'package:agwa/agwa/addSensor/addSensorPage.dart';
import 'package:agwa/screens/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../inventory/inventory_options.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  // int currentIndex = 0;
  // final screens = [
  //   addSensorPage(),
  //   Center(child: Text('Feed')),
  //   InventoryOptions(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Agwa', style: TextStyle(color: Colors.black)),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),

      body: Column(
        children: [
          SizedBox(height: 24),
          Center(
            child: Stack(children: [
              Container(
                child: Text(
                  "Current pH Level: 7",
                  textAlign: TextAlign.center,
                ),
                color: Colors.cyan,
                width: 320,
                padding: EdgeInsets.symmetric(vertical: 100.0),
              ),
            ]),
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
