// To parse this JSON data, do
//
//     final wondData = wondDataFromJson(jsonString);
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'dart:convert';

PondData pondDataFromJson(String str) => PondData.fromJson(json.decode(str));

String pondDataToJson(PondData data) => json.encode(data.toJson());

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

  factory PondData.fromJson(Map<String, dynamic> json) => PondData(
      birthdate: (json['birthdate'] as Timestamp).toDate(),
      initial_quantity: json['initial_quantity'],
      pond_ID: json['pond_ID'],
      species_name: json['species_name'],
      target_harvest_date: (json['target_harvest_date'] as Timestamp).toDate(),
      target_weight: json['target_weight'],
      id: json['id'],
      pH_level_range: json['target_weight']);

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
}



// //{
//     "Birthdate":"May 3, 2001",
//     "Initial Quantity":"123456789",
//     "PondID": "555",
//     "SpeciesName":"dddd",
//     "Target Harvest Date":"July 18, 2001",
//     "Target Weight": "5555",
//     "id": "OjUJpZ1f9yVYwDfV9LET",
// }