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

class PondsPage extends StatefulWidget {
  const PondsPage({super.key});

  @override
  State<PondsPage> createState() => _PondsPageState();
}

class _PondsPageState extends State<PondsPage> {
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {}
  Future<void> _delete(String productId) async {}

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                  child: const Text('Add'),
                ),
                SizedBox(width: 10),
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
                SizedBox(width: 10),
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
                )
              ],
            ),
            Container(
              height: 500,
              child: StreamBuilder(
                //stream: _ponds.snapshots(),
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
          ]),
        ));
  }
}
