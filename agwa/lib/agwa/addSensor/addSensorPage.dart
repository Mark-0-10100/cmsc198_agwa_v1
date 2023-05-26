import 'package:agwa/screens/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class addSensorPage extends StatefulWidget {
  const addSensorPage({super.key});

  @override
  State<addSensorPage> createState() => _addSensorPageState();
}

class _addSensorPageState extends State<addSensorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Container(child: Text("Add Sensor")),
          TextField(
            decoration: InputDecoration(hintText: "Enter Sensor ID"),
          ),
          ElevatedButton(onPressed: () {}, child: Text("Continue"))
        ],
      ),
    )
        // appBar: AppBar(
        //   body: Co
        //   title: Text('Add Sensor',
        //       style: TextStyle(color: Colors.black), textAlign: TextAlign.center),
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        );
  }
}
