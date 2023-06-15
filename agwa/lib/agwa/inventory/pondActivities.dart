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
import 'package:fluttertoast/fluttertoast.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  //For transaction page -------------------------------------------------------
  //final _modalKey = GlobalKey<FormState>();
  final _modalKey = GlobalKey<FormState>();
  final taskDescription_controller = TextEditingController();
  late var taskDeadlineDate_controller = TextEditingController();
  final taskStatus_controller = TextEditingController();
  //For transaction page -------------------------------------------------------

  final CollectionReference _activities =
      FirebaseFirestore.instance.collection("activities");

  //For transaction page -------------------------------------------------------
  // final CollectionReference _transactions =
  //     FirebaseFirestore.instance.collection("pond-species_inventory");
  //For transaction page -------------------------------------------------------

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
                  controller: taskDescription_controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Task Description',
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
                DateTimeFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'Deadline',
                  ),
                  mode: DateTimeFieldPickerMode.date, //If time or date
                  autovalidateMode: AutovalidateMode.always,
                  validator: (e) =>
                      (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                  onDateSelected: (DateTime value) {
                    taskDeadlineDate_controller =
                        value as TextEditingController;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: taskStatus_controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Status',
                  ),
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
                      final transactionsData = TransactionsData(
                        task_description: taskDescription_controller.text,
                        deadline_date: DateTime(2004, 7, 18),
                        task_status: taskStatus_controller.text,
                        // species_name: taskDescription_controller.text,
                        // birthdate: DateTime(2004, 7, 18),
                        // initial_quantity:
                        //     int.parse(taskStatus_controller.text),
                        // pH_level_range: int.parse(idealPHController.text),
                        // target_harvest_date: DateTime(2004, 7, 18),
                        // target_weight:
                        //     int.parse(targetWeight_controller.text)
                        //
                      );
                      createTransactionsData(transactionsData);

                      taskDescription_controller.text = '';
                      taskStatus_controller.text = '';
                      taskDeadlineDate_controller.text = '';

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
      taskDescription_controller.text = documentSnapshot['Task Description'];
      taskStatus_controller.text = documentSnapshot['Status'].toString();
      taskDeadlineDate_controller.text =
          documentSnapshot['Deadline'].toString();
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
                  controller: taskDescription_controller,
                  decoration:
                      const InputDecoration(labelText: 'Task Description'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  //controller: taskStatus_controller,
                  decoration: const InputDecoration(
                    labelText: 'Deadline',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: taskStatus_controller,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String transactionDescription_temp =
                        taskDescription_controller.text;
                    final double? taskStatus_controller_temp =
                        double.tryParse(taskStatus_controller.text);
                    // final String species_birth_dateValue_temp =
                    //     taskDeadlineDate_controller.text;
                    // final String target_HarvestDateController_temp =
                    //     target_HarvestDateController.text;

                    if (taskStatus_controller_temp != null) {
                      await _activities.doc(documentSnapshot!.id).update({
                        "Task Description": transactionDescription_temp,
                        //"Deadline": initialQuantity_temp,
                        "Status": taskStatus_controller_temp,
                      });
                      taskDescription_controller.text = '';
                      taskStatus_controller.text = '';
                      taskDeadlineDate_controller.text = '';
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

  Future<void> _delete(String transactionData_id) async {
    await _activities.doc(transactionData_id).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a Pond Data')));
  }

  @override
  Widget build(BuildContext context) {
    // final CollectionReference _activities =
    //     FirebaseFirestore.instance.collection("activities");
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
            'Activities',
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
            Expanded(
              child: Stack(children: [
                SingleChildScrollView(
                  child: Container(
                    height: 600,
                    child: StreamBuilder(
                      stream: _activities.snapshots(),
                      builder: (context, AsyncSnapshot snapshots) {
                        if (snapshots.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(color: Colors.green),
                          );
                        }
                        if (snapshots.hasData) {
                          final tasks = snapshots.data!.docs.toList();
                          final notDoneTasks = tasks.where((task) => task['Status'] == false).toList();

                          // Sort the tasks based on the nearest deadline
                          notDoneTasks.sort((a,b){
                            final DateTime deadlineA = a['Deadline'].toDate();
                            final DateTime deadlineB = b['Deadline'].toDate();
                            return deadlineA.compareTo(deadlineB);
                          });

                          return ListView.builder(
                            // itemCount: snapshots.data!.docs.length,
                            itemCount: notDoneTasks.length,
                            itemBuilder: (context, index) {
                              // final DocumentSnapshot records =
                              // snapshots.data!.docs[index];
                              final DocumentSnapshot task = notDoneTasks[index];

                              return Slidable(
                                startActionPane:
                                ActionPane(motion: StretchMotion(), children: [
                                  SlidableAction(
                                    onPressed: (context) => _update(task),
                                    icon: Icons.edit,
                                    backgroundColor: Colors.blue,
                                  ),
                                  SlidableAction(
                                    onPressed: (context) => _delete(task.id),
                                    icon: Icons.delete,
                                    backgroundColor: Colors.blue,
                                  ),
                                ]),
                                child: Card(
                                  child: ListTile(
                                      leading: Checkbox(
                                        value: false,
                                        onChanged: (value){
                                          if (value == true){
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.question,
                                              animType: AnimType.bottomSlide,
                                              title: 'Confirmation',
                                              desc: 'Are you sure you want to mark this as done?',
                                              btnCancelOnPress: (){},
                                              btnOkOnPress: (){
                                                // Update the task status
                                                _activities.doc(task.id).update({'Status':value});
                                                Fluttertoast.showToast(msg: 'Activity marked as done');
                                              },
                                              btnOkColor: Colors.cyan,
                                            ).show();
                                          } else {
                                            // Update the status to not done
                                            _activities.doc(task.id).update({'Status':false});
                                          }

                                        },
                                      ),
                                      title: Text("Task Description: " +
                                  task["Task Description"]),
                                  subtitle: Text("Deadline: " +
                                      task["Deadline"].toDate().toString()),
                                ),
                              ),

                              );
                            },
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(color: Colors.red),
                        );
                      },
                    ),
                  ),

                )
              ])
            )
          ]),
        ));
  }

  Future createTransactionsData(TransactionsData pondData) async {
    //Reference to document
    final docUser = FirebaseFirestore.instance.collection('activities').doc();

    // final user = User(
    //     id: docUser.id, name: name, age: 21, birthday: DateTime(2001, 7, 28));

    pondData.id = docUser.id;
    final json = pondData.toJson();

    await docUser.set(json);
  }
}

class TransactionsData {
  String id;
  final String task_description;
  final DateTime deadline_date;
  final String task_status;

  TransactionsData(
      {this.id = '',
      required this.task_description,
      required this.deadline_date,
      required this.task_status});

  Map<String, dynamic> toJson() => {
        'id': id,
        'Task Description': task_description,
        'Deadline': deadline_date,
        'Status': task_status
      };

  static TransactionsData fromJson(Map<String, dynamic> json) =>
      TransactionsData(
          id: json['id'],
          task_description: json['task_description'],
          deadline_date: (json['deadline_date'] as Timestamp).toDate(),
          task_status: json['task_status']);
}
