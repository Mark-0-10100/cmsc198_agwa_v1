//This version contains the simple form fields lang

import 'package:flutter/material.dart';

class PondsTemp extends StatefulWidget {
  const PondsTemp({Key? key}) : super(key: key);

  @override
  _PondsTempState createState() => _PondsTempState();
}

class _PondsTempState extends State<PondsTemp> {
  // Create a TextEditingController for each form field
  final dateController = TextEditingController();
  final intValueController = TextEditingController();
  final stringValueController = TextEditingController();
  final dateValue2Controller = TextEditingController();
  final doubleValue1Controller = TextEditingController();
  final doubleValue2Controller = TextEditingController();

  // Create a GlobalKey to access the modal sheet from anywhere in the code
  final _modalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose of the TextEditingControllers when the widget is disposed
    dateController.dispose();
    intValueController.dispose();
    stringValueController.dispose();
    dateValue2Controller.dispose();
    doubleValue1Controller.dispose();
    doubleValue2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: Center(
        child: ElevatedButton(
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
                        controller: dateController,
                        decoration: const InputDecoration(
                          labelText: 'Date',
                        ),
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid date';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: intValueController,
                        decoration: const InputDecoration(
                          labelText: 'Integer Value',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid integer';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: stringValueController,
                        decoration: const InputDecoration(
                          labelText: 'String Value',
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid string';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: dateValue2Controller,
                        decoration: const InputDecoration(
                          labelText: 'Date Value 2',
                        ),
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid date';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: doubleValue1Controller,
                        decoration: const InputDecoration(
                          labelText: 'Double Value 1',
                        ),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid number';
                          }
                          final double? number = double.tryParse(value);
                          if (number == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: doubleValue2Controller,
                        decoration: const InputDecoration(
                          labelText: 'Double Value 2',
                        ),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid number';
                          }
                          final double? number = double.tryParse(value);
                          if (number == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_modalKey.currentState?.validate() ?? false) {
                            // If the form is valid, add the entry and close the modal
                            //_addEntry();
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Add Entry'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const Text('Add'),
        ),
      ),
    );
  }
}


// showModalBottomSheet(builder: (BuildContext context) {  }, context: null
//             );