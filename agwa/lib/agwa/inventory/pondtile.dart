import 'package:agwa/agwa/inventory/ponddata.dart';
import 'package:flutter/material.dart';
import 'package:agwa/agwa/inventory/pondsList.dart';

class PondTile extends StatelessWidget {
  final PondData pondData;
  PondTile({required this.pondData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[50],
          ),
          title: Text(pondData.species_name),
          subtitle: Text('Takes ${pondData.initial_quantity} sugar(s)'),
        ),
      ),
    );
  }
}
