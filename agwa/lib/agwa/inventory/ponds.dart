// This version contains draft code for the polished design
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
import 'package:agwa/agwa/inventory/final_pond_dependencies/moodel_pondsData.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class PondsPage extends StatefulWidget {
  const PondsPage({super.key});

  @override
  State<PondsPage> createState() => _PondsPageState();
}

class _PondsPageState extends State<PondsPage> {
  final _modalKey = GlobalKey<FormState>();
  final initialQuantity_controller = TextEditingController();
  final targetWeight_controller = TextEditingController();

  final speciesName_controller = TextEditingController();
  late var target_HarvestDateController = TextEditingController();
  final idealPHController = TextEditingController();
  late var species_birth_dateValue_controller = TextEditingController();

  final CollectionReference _ponds =
      FirebaseFirestore.instance.collection("pond-species_inventory");

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        context: context,
        builder: ((context) {
          return Form(
            key: _modalKey,
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                TextFormField(
                  controller: speciesName_controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
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
                SizedBox(height: 10),
                TextFormField(
                  controller: initialQuantity_controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Initial Quantity',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid string';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                DateTimeFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'Select Birthdate',
                  ),
                  mode: DateTimeFieldPickerMode.date, //If time or date
                  autovalidateMode: AutovalidateMode.always,
                  validator: (e) =>
                      (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                  onDateSelected: (DateTime value) {
                    species_birth_dateValue_controller =
                        value as TextEditingController;
                  },
                ),
                SizedBox(height: 10),
                DateTimeFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'Target Harvest Date',
                  ),
                  mode: DateTimeFieldPickerMode.date, //If time or date
                  autovalidateMode: AutovalidateMode.always,
                  validator: (e) =>
                      (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                  onDateSelected: (DateTime value) {
                    target_HarvestDateController =
                        value as TextEditingController;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: targetWeight_controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Target Weight',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid string';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: idealPHController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ideal pH Level',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid string';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                AnimatedButton(
                  text: "Add Entry",
                  pressEvent: () {
                    if (_modalKey.currentState?.validate() ?? false) {
                      final pondData = PondData(
                          species_name: speciesName_controller.text,
                          birthdate: DateTime(2004, 7, 18),
                          initial_quantity:
                              int.parse(initialQuantity_controller.text),
                          pH_level_range: int.parse(idealPHController.text),
                          target_harvest_date: DateTime(2004, 7, 18),
                          target_weight:
                              int.parse(targetWeight_controller.text));
                      createPondData(pondData);
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.bottomSlide,
                        showCloseIcon: false,
                        dismissOnTouchOutside: true,
                        autoDismiss: true,
                        btnOkOnPress: () {
                          Navigator.pop(context);
                        },
                        title: "Success",
                        desc: "Pond Data Successfully added!",
                      ).show();
                    }
                  },
                ),
              ],
            ),
          );
        }));
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      initialQuantity_controller.text =
          documentSnapshot['Initial Quantity'].toString();

      targetWeight_controller.text =
          documentSnapshot['Target Weight'].toString();

      speciesName_controller.text = documentSnapshot['Species Name'];

      target_HarvestDateController.text =
          documentSnapshot['Target Harvest Date'].toString();
      species_birth_dateValue_controller.text =
          documentSnapshot['Birthdate'].toString();

      idealPHController.text = documentSnapshot['pH Level Range'].toString();
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
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: initialQuantity_controller,
                  decoration: const InputDecoration(
                    labelText: 'Initial Quantity',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  //controller: initialQuantity_controller,
                  decoration: const InputDecoration(
                    labelText: 'Birthdate',
                  ),
                ),
                // DateTimeFormField(
                //   decoration: const InputDecoration(
                //     hintStyle: TextStyle(color: Colors.black45),
                //     errorStyle: TextStyle(color: Colors.redAccent),
                //     border: OutlineInputBorder(),
                //     suffixIcon: Icon(Icons.event_note),
                //     labelText: 'Select Birthdate',
                //   ),
                //   mode: DateTimeFieldPickerMode.date, //If time or date
                //   autovalidateMode: AutovalidateMode.always,
                //   validator: (e) =>
                //       (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                //   onDateSelected: (DateTime value) {
                //     species_birth_dateValue_controller =
                //         value as TextEditingController;
                //   },
                // ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  //controller: initialQuantity_controller,
                  decoration: const InputDecoration(
                    labelText: 'Target Harvest Date',
                  ),
                ),
                // DateTimeFormField(
                //   decoration: const InputDecoration(
                //     hintStyle: TextStyle(color: Colors.black45),
                //     errorStyle: TextStyle(color: Colors.redAccent),
                //     border: OutlineInputBorder(),
                //     suffixIcon: Icon(Icons.event_note),
                //     labelText: 'Select Birthdate',
                //   ),
                //   mode: DateTimeFieldPickerMode.date, //If time or date
                //   autovalidateMode: AutovalidateMode.always,
                //   validator: (e) =>
                //       (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                //   onDateSelected: (DateTime value) {
                //     species_birth_dateValue_controller =
                //         value as TextEditingController;
                //   },
                // ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: targetWeight_controller,
                  decoration: const InputDecoration(
                    labelText: 'Target Weight',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: idealPHController,
                  decoration: const InputDecoration(
                    labelText: 'Ideal pH Level Range',
                  ),
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String speciesName_temp = speciesName_controller.text;
                    final double? initialQuantity_temp =
                        double.tryParse(initialQuantity_controller.text);
                    // final String species_birth_dateValue_temp =
                    //     species_birth_dateValue_controller.text;
                    // final String target_HarvestDateController_temp =
                    //     target_HarvestDateController.text;
                    final String targetWeight_temp =
                        targetWeight_controller.text;
                    final String idealPH_temp = idealPHController.text;

                    if (initialQuantity_temp != null) {
                      await _ponds.doc(documentSnapshot!.id).update({
                        "Species Name": speciesName_temp,
                        "Pond ID": initialQuantity_temp,
                        // "Birthdate": species_birth_dateValue_temp,
                        // "Target Harvest Date": target_HarvestDateController_temp,
                        "Target Weight": targetWeight_temp,
                        "pH Level Range": idealPH_temp,
                      });
                      speciesName_controller.text = '';
                      initialQuantity_controller.text = '';
                      species_birth_dateValue_controller.text = '';
                      target_HarvestDateController.text = '';
                      targetWeight_controller.text = '';
                      idealPHController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }

  Future<void> _delete(String pondData_id) async {
    await _ponds.doc(pondData_id).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a Pond Data')));
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference _ponds =
        FirebaseFirestore.instance.collection("pond-species_inventory");

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 37, 162, 187),
              size: 40.0,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          titleSpacing: -10,
          title: Text(
            'Ponds',
            style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 48,
                fontWeight: FontWeight.w700,
                color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => _create(),
                  child: const Text('Add'),
                ),
                SizedBox(width: 10),
              ],
            ),
            Container(
              height: 600,
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
                            ),
                          ]),
                          child: ListTile(
                            title: Text(
                                "Species name: " + records["Species Name"]),
                            subtitle: Text("Initial Quantity: " +
                                records["Initial Quantity"].toString() +
                                "\nBirthdate: " +
                                records["Birthdate"].toDate().toString() +
                                "\nTarget Harvest Date: " +
                                records["Target Harvest Date"]
                                    .toDate()
                                    .toString() +
                                "\nTarget Weight: " +
                                records["Target Weight"].toString() +
                                "\nIdeal pH Level Range: " +
                                records["pH Level Range"].toString()),
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
          ]),
        ));
  }

  Future createPondData(PondData pondData) async {
    //Reference to document
    final docUser =
        FirebaseFirestore.instance.collection('pond-species_inventory').doc();

    // final user = User(
    //     id: docUser.id, name: name, age: 21, birthday: DateTime(2001, 7, 28));

    pondData.id = docUser.id;
    final json = pondData.toJson();

    await docUser.set(json);
  }
}

class PondData {
  String id;
  final DateTime birthdate;
  final int initial_quantity;
  final String species_name;
  final DateTime target_harvest_date;
  final int target_weight;
  final int pH_level_range;

  PondData({
    this.id = '',
    required this.birthdate,
    required this.initial_quantity,
    required this.species_name,
    required this.target_harvest_date,
    required this.target_weight,
    required this.pH_level_range,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'Birthdate': birthdate,
        'Initial Quantity': initial_quantity,
        'Species Name': species_name,
        'Target Harvest Date': target_harvest_date,
        'Target Weight': target_weight,
        'pH Level Range': pH_level_range
      };

  static PondData fromJson(Map<String, dynamic> json) => PondData(
      birthdate: (json['birthdate'] as Timestamp).toDate(),
      initial_quantity: json['initial_quantity'],
      species_name: json['species_name'],
      target_harvest_date: (json['target_harvest_date'] as Timestamp).toDate(),
      target_weight: json['target_weight'],
      id: json['id'],
      pH_level_range: json['pH_level_range']);
}
