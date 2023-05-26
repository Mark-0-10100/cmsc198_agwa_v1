import 'package:agwa/screens/authenticate/register.dart';
import 'package:agwa/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class AuthenticatePage extends StatefulWidget {
  const AuthenticatePage({super.key});

  @override
  State<AuthenticatePage> createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == true) {
      //You need to pass the function as parameter to the stateful widget
      return SignInPage(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
