import 'package:agwa/screens/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agwa/agwa/inventory/ponds.dart';
import 'package:agwa/agwa/inventory/transactions.dart';
import 'package:agwa/agwa/inventory/pondActivities.dart';
import 'package:agwa/agwa/inventory/pondstestfiles/ponds_v3.dart';

class InventoryOptions extends StatefulWidget {
  const InventoryOptions({super.key});

  @override
  State<InventoryOptions> createState() => _InventoryOptionsState();
}

class _InventoryOptionsState extends State<InventoryOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => PondsPage()));
              },
              icon: Icon(Icons.image),
              label: Text("Ponds"),
              style: ElevatedButton.styleFrom(
                // Customize the button's appearance
                primary: Colors.blue,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(16),
              ),
          ),
              // child: Text("Ponds")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => TransactionsPage()));
              },
              child: Text("Transactions")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ActivitiesPage()));
              },
              child: Text("Pond Activities")),
        ],
      )),
    );
  }
}
