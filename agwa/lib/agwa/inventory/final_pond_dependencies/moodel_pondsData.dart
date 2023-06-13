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
import 'package:agwa/agwa/inventory/pondsList.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
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

//Modifying this to have a better named class

class PondData {
  String id;
  final DateTime birthdate;
  final int initial_quantity;
  final int pond_ID;
  final String species_name;
  final DateTime target_harvest_date;
  final int target_weight;
  final int pH_level_range;

  PondData({
    this.id = '',
    required this.birthdate,
    required this.initial_quantity,
    required this.pond_ID,
    required this.species_name,
    required this.target_harvest_date,
    required this.target_weight,
    required this.pH_level_range,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'Birthdate': birthdate,
        'Initial Quantity': initial_quantity,
        'Pond ID': pond_ID,
        'Species Name': species_name,
        'Target Harvest Date': target_harvest_date,
        'Target Weight': target_weight,
        'pH Level Range': pH_level_range
      };

  static PondData fromJson(Map<String, dynamic> json) => PondData(
      birthdate: (json['birthdate'] as Timestamp).toDate(),
      initial_quantity: json['initial_quantity'],
      pond_ID: json['pond_ID'],
      species_name: json['species_name'],
      target_harvest_date: (json['target_harvest_date'] as Timestamp).toDate(),
      target_weight: json['target_weight'],
      id: json['id'],
      pH_level_range: json['target_weight']);
}


//Using "User"

// class User {
//   String id;
//   final DateTime birthdate;
//   final int initial_quantity;
//   final int pond_ID;
//   final String species_name;
//   final DateTime target_harvest_date;
//   final int target_weight;
//   final int pH_level_range;

//   User({
//     this.id = '',
//     required this.birthdate,
//     required this.initial_quantity,
//     required this.pond_ID,
//     required this.species_name,
//     required this.target_harvest_date,
//     required this.target_weight,
//     required this.pH_level_range,
//   });

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'Birthdate': birthdate,
//         'Initial Quantity': initial_quantity,
//         'Pond ID': pond_ID,
//         'Species Name': species_name,
//         'Target Harvest Date': target_harvest_date,
//         'Target Weight': target_weight,
//         'pH Level Range': pH_level_range
//       };

//   static User fromJson(Map<String, dynamic> json) => User(
//       birthdate: (json['birthdate'] as Timestamp).toDate(),
//       initial_quantity: json['initial_quantity'],
//       pond_ID: json['pond_ID'],
//       species_name: json['species_name'],
//       target_harvest_date: (json['target_harvest_date'] as Timestamp).toDate(),
//       target_weight: json['target_weight'],
//       id: json['id'],
//       pH_level_range: json['target_weight']);
// }