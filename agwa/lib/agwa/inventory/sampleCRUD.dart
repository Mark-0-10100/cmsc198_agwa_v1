import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

class sampleCRUD extends StatefulWidget {
  const sampleCRUD({super.key});

  @override
  State<sampleCRUD> createState() => _sampleCRUDState();
}

class _sampleCRUDState extends State<sampleCRUD> {
//A Controller for what is on the text field
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  // dateTimeFormField does not need controller
  // final controllerDate = TextEditingController();
  late var dateValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('Ponds Management', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextField(
              controller: controllerName,
              decoration: InputDecoration(
                helperText: 'Name',
              ),
            ),
            SizedBox(height: 24),
            TextField(
              controller: controllerAge,
              decoration: InputDecoration(
                helperText: 'Age',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
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
                dateValue = value as TextEditingController;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              child: Text('Create'),
              onPressed: () {
                final user = User(
                    name: controllerName.text,
                    age: int.parse(controllerAge.text),
                    birthday: DateTime.parse(dateValue.text));

                createUser(user);
                Navigator.pop(context);
              },
            )
          ],
        ));
  }

  //The method that will actually send the data to firebase
  Future createUser(User user) async {
    //Reference to document
    final docUser = FirebaseFirestore.instance.collection('users').doc();

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
  final String name;
  final int age;
  final DateTime birthday;

  User({
    this.id = '',
    required this.name,
    required this.age,
    required this.birthday,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'birthday': birthday,
      };
}
