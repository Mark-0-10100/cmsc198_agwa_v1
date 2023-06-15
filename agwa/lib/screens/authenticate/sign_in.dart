import 'package:agwa/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:agwa/screens/authenticate/authenticate.dart';
import 'package:agwa/shared/constants.dart';
import 'package:agwa/screens/authenticate/register.dart';

class SignInPage extends StatefulWidget {
  final Function toggleView;
  SignInPage({super.key, required this.toggleView});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _auth = AuthService();

  // key to associate data
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  // error state
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          // padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 100),
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/logo_agwa.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Text("Login",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10),
                      Text("Login to your account",
                        style: TextStyle(
                            fontSize: 15,
                            color:Colors.grey[700]),)
                    ],
                  ),
                  // ],
                  // ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          // SizedBox(height:0),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter email',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                            // textInputDecoration.copyWith(hintText: 'Enter email'),
                            validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter Password',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                            // textInputDecoration.copyWith(hintText: 'Enter Password'),
                            obscureText: true,
                            validator: (val) =>
                            val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                          ),
                          SizedBox(height: 20.0),

                          Padding(
                            padding:EdgeInsets.symmetric(horizontal: 40),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  dynamic result = await _auth.signInWithEmailAndPassword(
                                      email, password);
                                  if (result == null) {
                                    setState(() => error = 'credentials are not valid.');
                                  }
                                }
                              },
                              color: Color(0xff0095FF),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      GestureDetector(
                        onTap:() {
                          // Navigate to the register page
                          widget.toggleView();
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.blue,
                        ),)
                      ),
                    ],
                  ),
                ],
              ),),
            ],),
        ),
      )


    );
  }
}

