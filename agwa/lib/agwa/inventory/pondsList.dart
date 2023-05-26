import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:agwa/agwa/inventory/ponddata.dart';
import 'package:agwa/agwa/inventory/pondtile.dart';

class PondList extends StatefulWidget {
  @override
  _PondListState createState() => _PondListState();
}

class _PondListState extends State<PondList> {
  @override
  Widget build(BuildContext context) {
    final pondData = Provider.of<List<PondData>>(context);

    return ListView.builder(
      itemCount: pondData.length,
      itemBuilder: (context, index) {
        return PondTile(pondData: pondData[index]);
      },
    );
  }
}
