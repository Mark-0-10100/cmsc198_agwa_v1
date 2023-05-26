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

class PondsPage extends StatefulWidget {
  const PondsPage({super.key});

  @override
  State<PondsPage> createState() => _PondsPageState();
}

class _PondsPageState extends State<PondsPage> {
  final initialQuantity_controller = TextEditingController();
  final pondID_controller = TextEditingController();
  final targetWeight_controller = TextEditingController();

  final speciesName_controller = TextEditingController();
  final dateController = TextEditingController();
  late var species_birth_dateValue_controller = TextEditingController();

  // Create a GlobalKey to access the modal sheet from anywhere in the code
  final _modalKey = GlobalKey<FormState>();

  //=======TEMP NEW=================
  List<PondData> ponddata = [];

  @override
  void initState() {
    fetchRecords();
    super.initState();
  }

  fetchRecords() async {
    var records = await FirebaseFirestore.instance
        .collection('pond-species_inventory')
        .get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map((ponddata) => PondData(
            id: ponddata.id,
            birthdate: ponddata['birthdate'],
            initial_quantity: ponddata['initial_quantity'],
            pond_ID: ponddata['pond_ID'],
            species_name: ponddata['species_name'],
            target_harvest_date: ponddata['target_harvest_date'],
            target_weight: ponddata['target_weight'],
            pH_level_range: ponddata['pH_level_range']))
        .toList();

    setState(() {
      ponddata = _list;
    });
  }

  //=======TEMP NEW=================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Ponds Management', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: ponddata.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(ponddata[index].species_name),
              subtitle: Text(ponddata[index].pond_ID as String),
            );
          }),
    );
  }

  // Future createUser(
  //     {required String species_name}) async {
  //   // Reference to firestore

  //   final docUser =
  //       FirebaseFirestore.instance.collection('pond-species_inventory').doc();

  //   final json = {
  //     'Birthdate': species_birth_dateValue,
  //     'Initial Quantity': 22,
  //     'Pond ID': 20890,
  //     'Species Name': species_name,
  //     'Target Harvest Date': DateTime(2004, 7, 18),
  //     'Target Weight': 21,
  //     'pH Level Range': 33
  //   };

  //   await docUser.set(json);
  // }

  Widget buildUser(User user) => ListTile(
      leading: CircleAvatar(child: Text('${user.pond_ID}')),
      title: Text(user.species_name),
      subtitle: Text(user.birthdate.toIso8601String()));

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('pond-species_inventory')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  Future createUser(User user) async {
    //Reference to document
    final docUser =
        FirebaseFirestore.instance.collection('pond-species_inventory').doc();

    // final user = User(
    //     id: docUser.id, name: name, age: 21, birthday: DateTime(2001, 7, 28));

    user.id = docUser.id;
    final json = user.toJson();

    await docUser.set(json);
  }
}

//using class models to set the key in keyvalue pair for firebase data
class User {
  String id;
  final DateTime birthdate;
  final int initial_quantity;
  final int pond_ID;
  final String species_name;
  final DateTime target_harvest_date;
  final int target_weight;
  final int pH_level_range;

  //   final json = {
  //     'Birthdate': species_birth_dateValue,
  //     'Initial Quantity': 22,
  //     'Pond ID': 20890,
  //     'Species Name': species_name,
  //     'Target Harvest Date': DateTime(2004, 7, 18),
  //     'Target Weight': 21,
  //     'pH Level Range': 33
  //   };

  User({
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

  static User fromJson(Map<String, dynamic> json) => User(
      birthdate: (json['birthdate'] as Timestamp).toDate(),
      initial_quantity: json['initial_quantity'],
      pond_ID: json['pond_ID'],
      species_name: json['species_name'],
      target_harvest_date: (json['target_harvest_date'] as Timestamp).toDate(),
      target_weight: json['target_weight'],
      id: json['id'],
      pH_level_range: json['target_weight']);
}
