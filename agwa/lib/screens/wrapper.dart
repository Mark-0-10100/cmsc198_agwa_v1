import 'package:agwa/screens/authenticate/authenticate.dart';
import 'package:agwa/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agwa/models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    if (user == null) {
      return AuthenticatePage();
    } else {
      return HomePage();
    }
  }
}
