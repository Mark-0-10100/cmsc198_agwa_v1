
import 'package:agwa/agwa/homepage/homepage.dart';
import 'package:agwa/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:agwa/screens/authenticate/authenticate.dart';
import 'package:agwa/shared/constants.dart';

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

  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
      if (result == null) {
        setState(() => error = 'Credentials are not valid.');
      }
      else {
        // Navigate to the homepage after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => homePage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 200, 255, 236),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 0, 63, 77),
        elevation: 0.0,
        // brightness: Brightness.light,
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   onPressed:(){
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(Icons.arrow_back_ios,
        //   size: 20,
        //   color: Colors.black,),
        // )
        // title: Text('Sign in to Agwa'),
        // actions: <Widget>[
        //   TextButton.icon(
        //       icon: Icon(Icons.person),
        //       label: Text('Register'),
        //       onPressed: () {
        //         widget.toggleView();
        //       })
        // ],
      ),
      body: Container(
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
                            fit: BoxFit.fitHeight
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        inputFile(label: "Email"),
                        inputFile(label: "Password", obscureText: true)
                      ],
                    ),
                  ),
                  Padding(
                      padding:EdgeInsets.symmetric(horizontal: 40),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: signIn,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?"),
                    Text("Sign up", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),)
                  ],
                ),
            ]
            ),)
          ],
        ),
      ),
    );
  }
}

Widget inputFile({label, obscureText = false})
{
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color:Colors.black87
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0,
              horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey
                ),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)
              ),
            ),
        ),
        SizedBox(height: 19,),
      ]
  );
}
