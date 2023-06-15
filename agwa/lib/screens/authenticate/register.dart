import 'package:flutter/material.dart';
import '../../services/auth.dart';
import 'package:agwa/screens/authenticate/authenticate.dart';
import 'package:agwa/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                      Text("Register",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10),
                      Text("Register an account",
                        style: TextStyle(
                            fontSize: 15,
                            color:Colors.grey[700]),)
                    ],
                  ),
                  Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>[
                    // SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter a valid email',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter a valid password',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
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
                            dynamic result = await _auth.registerWithEmailAndPassword(
                                email, password);
                            if (result == null) {
                              setState(() => error = 'Please supply a valid email.');
                            }
                          }
                        },
                        color: Color(0xff0095FF),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
                  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Already have an account?"),
              GestureDetector(
                  onTap:() {
                    // Navigate to the register page
                    widget.toggleView();
                  },
                  child: Text(
                    "Log in",
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
