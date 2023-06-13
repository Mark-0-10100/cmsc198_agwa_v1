import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agwa/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../agwa/addSensor/addSensorPage.dart';
import '../../agwa/homepage/homepage.dart';
import '../../agwa/inventory/inventory_options.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  int currentIndex = 0;
  final screens = [
    //addSensorPage(),
    homePage(),
    InventoryOptions(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 200, 255, 236),
      appBar: AppBar(
        title: Text('Agwa'),
        backgroundColor: Color.fromARGB(255, 0, 63, 77),
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          //BottomNavigationBarItem(label: "Sensor", icon: Icon(Icons.sensors)),
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Inventory',
            icon: Icon(Icons.inventory),
          )
        ],
      ),
    );
    // return Container(child: Text('This is the homepage'));
  }
}
