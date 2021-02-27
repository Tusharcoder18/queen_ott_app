import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:queen_ott_app/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _emailPhone;
  String _password;
  String _confirmPassword;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: [
            _headerWidget(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
            ),
            _formWidget(),
          ],
        ),
      ),
    );
  }

  Widget _headerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // SizedBox(
        //   width: 5.0,
        // ),
        Text(
          "QUEEN",
          style: TextStyle(
            color: Colors.red,
            letterSpacing: 2.0,
            fontFamily: 'Roboto',
            fontSize: 30.0,
          ),
        ),
        Container(
          height: 70,
          child: Image.asset('assets/logo.png'),
        ),
      ],
    );
  }

  Widget _formWidget() {
    return Form(
      key: _formKey,
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                      labelText: "Email or Phone Number"),
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Email or Phone Number is Required";
                    }
                  },
                  onSaved: (String value) {
                    _emailPhone = value;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Container for just password
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                      labelText: "Password"),
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Password is Required";
                    }
                  },
                  onSaved: (String value) {
                    _password = value;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // Container for confirm password
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                      labelText: "Confirm Password"),
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Password is Required";
                    }
                    else if (_password != _confirmPassword) {
                      return "Password did not match";
                    }
                  },
                  onSaved: (String value) {
                    _confirmPassword = value;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  print(_emailPhone);
                  print(_password);
                },
                child: MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () {
                    setState(() {
                    });
                    if(_password == _confirmPassword){
                      print("password Confirmed");
                    }
                    else{
                      print("password Not Confirmed");
                    }

                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();
                    print(_emailPhone);
                    print(_password);
                  },
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey[600]),
                      borderRadius: BorderRadius.circular(3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Sign up',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                  textColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 50,
                onPressed: () {},
                color: Colors.redAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.google),
                    SizedBox(width: 10),
                    Text('Sign-up using Google',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
                textColor: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 50,
                onPressed: () {},
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.facebook),
                    SizedBox(width: 10),
                    Text(
                      'Sign-up using Facebook',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                textColor: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 10,
              ),
              Text("Need Help?"),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                child: Text(
                  "Already a user? Sign in now.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
// Widget
}
