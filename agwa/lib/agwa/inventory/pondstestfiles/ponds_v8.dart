//This version contains the first working prototype of the complete CRUD

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

  //**** the more new **********

  //NEW
  final CollectionReference _ponds =
      FirebaseFirestore.instance.collection("pond-species_inventory");

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: speciesName_controller,
                  decoration: const InputDecoration(labelText: 'Species Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: pondID_controller,
                  decoration: const InputDecoration(
                    labelText: 'Pond ID',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String name = speciesName_controller.text;
                    final double? price =
                        double.tryParse(pondID_controller.text);
                    if (price != null) {
                      await _ponds
                          .add({"Species Name": name, "Pond ID": price});

                      speciesName_controller.text = '';
                      pondID_controller.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      speciesName_controller.text = documentSnapshot['Species Name'];
      pondID_controller.text = documentSnapshot['Pond ID'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: speciesName_controller,
                  decoration: const InputDecoration(labelText: 'Species Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: pondID_controller,
                  decoration: const InputDecoration(
                    labelText: 'Pond ID',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String name = speciesName_controller.text;
                    final double? price =
                        double.tryParse(pondID_controller.text);
                    if (price != null) {
                      await _ponds
                          .doc(documentSnapshot!.id)
                          .update({"Species Name": name, "Pond ID": price});
                      speciesName_controller.text = '';
                      pondID_controller.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _ponds.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  //**** the more new **********

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
      body: Center(
        child: Column(
          children: [
            Container(
              height: 500,
              child: StreamBuilder(
                stream: _ponds.snapshots(),
                builder: (context, AsyncSnapshot snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    );
                  }
                  if (snapshots.hasData) {
                    return ListView.builder(
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot records =
                            snapshots.data!.docs[index];
                        return Slidable(
                          startActionPane:
                              ActionPane(motion: StretchMotion(), children: [
                            SlidableAction(
                              onPressed: (context) => _update(records),
                              icon: Icons.edit,
                              backgroundColor: Colors.blue,
                            ),
                            SlidableAction(
                              onPressed: (context) => _delete(records.id),
                              icon: Icons.delete,
                              backgroundColor: Colors.blue,

                              //() => _update(_ponds)
                            ),
                          ]),
                          child: ListTile(
                            title: Text(records["Species Name"]),
                            subtitle: Text(records["Pond ID"].toString()),
                          ),
                        );

                        // return Container(
                        //   color: Colors.red,
                        //   height: 40,
                        //   margin: EdgeInsets.symmetric(vertical: 10),
                        // );
                      },
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Form(
                          key: _modalKey,
                          child: ListView(
                            padding: const EdgeInsets.all(16.0),
                            children: [
                              TextFormField(
                                controller: initialQuantity_controller,
                                decoration: const InputDecoration(
                                  labelText: 'Initial Quantity',
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid string';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 24),
                              TextFormField(
                                controller: pondID_controller,
                                decoration: const InputDecoration(
                                  labelText: 'Pond ID',
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid string';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 24),
                              TextFormField(
                                controller: targetWeight_controller,
                                decoration: const InputDecoration(
                                  labelText: 'Pond ID',
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid string';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 24),
                              DateTimeFormField(
                                decoration: const InputDecoration(
                                  hintStyle: TextStyle(color: Colors.black45),
                                  errorStyle:
                                      TextStyle(color: Colors.redAccent),
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.event_note),
                                  labelText: 'Select Birthdate',
                                ),
                                mode: DateTimeFieldPickerMode
                                    .date, //If time or date
                                autovalidateMode: AutovalidateMode.always,
                                validator: (e) => (e?.day ?? 0) == 1
                                    ? 'Please not the first day'
                                    : null,
                                onDateSelected: (DateTime value) {
                                  species_birth_dateValue_controller =
                                      value as TextEditingController;
                                },
                              ),

                              // DateTimeFormField(
                              //   decoration: const InputDecoration(
                              //     hintStyle: TextStyle(color: Colors.black45),
                              //     errorStyle: TextStyle(color: Colors.redAccent),
                              //     border: OutlineInputBorder(),
                              //     suffixIcon: Icon(Icons.event_note),
                              //     labelText: 'Select Birthdate',
                              //   ),
                              //   mode:
                              //       DateTimeFieldPickerMode.date, //If time or date
                              //   //autovalidateMode: AutovalidateMode.always,
                              //   validator: (e) => (e?.day ?? 0) == 1
                              //       ? 'Please not the first day'
                              //       : null,
                              //   onDateSelected: (DateTime value) {
                              //     species_birth_dateValue =
                              //         value as TextEditingController;
                              //   },
                              // ),
                              SizedBox(height: 24),
                              TextFormField(
                                controller: speciesName_controller,
                                decoration: const InputDecoration(
                                  labelText: 'Species Name',
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid string';
                                  }
                                  return null;
                                },
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_modalKey.currentState?.validate() ??
                                      false) {
                                    // If the form is valid, add the entry and close the modal
                                    //_addEntry();
                                    final user = User(
                                        species_name:
                                            speciesName_controller.text,
                                        birthdate: DateTime(2004, 7, 18),
                                        initial_quantity: int.parse(
                                            initialQuantity_controller.text),
                                        pH_level_range: 3,
                                        pond_ID:
                                            int.parse(pondID_controller.text),
                                        target_harvest_date:
                                            DateTime(2004, 7, 18),
                                        target_weight: int.parse(
                                            targetWeight_controller.text));
                                    createUser(user);

                                    //createUser(species_name: species_name);
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text('Add Entry'),
                              ),
                            ],
                          ));
                    });
              },
              child: const Text('Add'),
            ),
            ElevatedButton(
              onPressed: () {
                final docUser = FirebaseFirestore.instance
                    .collection('pond-species_inventory')
                    .doc('wcF75LOaXpjvAexRh31C');

                //update specific fields
                docUser.update({
                  docUser.update({'Species Name': 'Isda'})
                } as Map<Object, Object?>);

                //updateUser();
              },
              child: const Text('Update'),
            ),
            ElevatedButton(
              onPressed: () {
                final docUser = FirebaseFirestore.instance
                    .collection('pond-species_inventory')
                    .doc('wcF75LOaXpjvAexRh31C');

                //update specific fields
                docUser.delete();

                //updateUser();
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
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

  // Future updateUser(User user) async {
  //   //Reference to document
  //   final docUser =
  //       FirebaseFirestore.instance.collection('pond-species_inventory').doc();

  //   // final user = User(
  //   //     id: docUser.id, name: name, age: 21, birthday: DateTime(2001, 7, 28));

  //   user.id = docUser.id;
  //   final json = user.toJson();

  //   await docUser.set(json);
  // }

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
