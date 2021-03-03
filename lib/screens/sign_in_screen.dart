import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:queen_ott_app/authentication_service.dart';
import 'package:queen_ott_app/screens/intermediate_screen.dart';
import 'package:queen_ott_app/screens/sign_up_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_button.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _emailPhone;
  String _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return IntermediateScreen();
    }
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
        Text(
          "QUEEN",
          style: TextStyle(
            color: Colors.white,
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
                  onChanged: (String value) {
                    _emailPhone = value;
                    print(_emailPhone);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
                  onChanged: (String value) {
                    _password = value;
                    print(_password);
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 50,
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  print(_emailPhone);
                  print(_password);
                  context.read<AuthenticationService>().signIn(
                        email: _emailPhone,
                        password: _password,
                      );
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[600]),
                    borderRadius: BorderRadius.circular(3)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Sign in',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
                textColor: Colors.white,
              ),
              SizedBox(
                height: 15,
              ),
              CustomButton(
                  text: "Sign-in using Google",
                  icon: Icon(FontAwesomeIcons.google),
                  color: Colors.red,
                  onTap: () {
                    print(context
                        .read<AuthenticationService>()
                        .signInWithGoogle());
                  }),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                  text: "Sign-in using Facebook",
                  icon: Icon(FontAwesomeIcons.facebook),
                  color: Colors.blue,
                  onTap: () {
                    print(context
                        .read<AuthenticationService>()
                        .signInWithFacebook());
                  }),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                  text: "Sign-in using Apple",
                  icon: Icon(FontAwesomeIcons.apple),
                  color: Colors.white,
                  onTap: () {}),
              SizedBox(
                height: 10,
              ),
              Text("Need Help?"),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                child: Text(
                  "New to Queen? Sign up now.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
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
