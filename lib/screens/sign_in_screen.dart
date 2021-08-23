import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:queen_ott_app/screens/user_home_screen.dart';
import 'package:queen_ott_app/services/add_series_services.dart';
import 'package:queen_ott_app/services/auth_service.dart';
import 'package:queen_ott_app/services/authentication_service.dart';
import 'package:queen_ott_app/screens/sign_up_screen.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/services/upload_service.dart';
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
      return HomeScreen();
    }
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.06,
              ),
              child: Center(
                child: Container(
                  height: 100,
                  child: Image.asset('assets/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            _formWidget(),
          ],
        ),
      ),
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
                    labelText: "Email or Phone Number",
                  ),
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
                    labelText: "Password",
                  ),
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
                onPressed: () => Provider.of<AuthBase>(context, listen: false)
                    .signInWithEmailAndPassword(_emailPhone, _password),
                // onPressed: () {
                //   if (!_formKey.currentState.validate()) {
                //     return;
                //   }
                //   _formKey.currentState.save();
                //   print(_emailPhone);
                //   print(_password);
                //   Provider.of<UploadService>(context, listen: false)
                //       .getEmailID(emailId: _emailPhone);
                //   Provider.of<AddSeriesServices>(context, listen: false)
                //       .getEmailId(email: _emailPhone);
                //   context.read<AuthenticationService>().signIn(
                //         email: _emailPhone,
                //         password: _password,
                //       );
                // },
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey[600]),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sign in',
                      style: Theme.of(context).textTheme.headline1,
                    ),
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
                onTap: () => Provider.of<AuthBase>(context, listen: false).signInWithGoogle(),
                // onTap: () {
                //   Provider.of<AuthenticationService>(context).googleSignIn;
                //   print('User Details:');
                //   print(
                //     context.read<AuthenticationService>().signInWithGoogle(),
                //   );
                // },
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                  text: "Sign-in using Facebook",
                  icon: Icon(FontAwesomeIcons.facebook),
                  color: Colors.blue,
                  onTap: () =>
                      Provider.of<AuthenticationService>(context, listen: false)
                          .signInWithFacebook()
                  // onTap: () {
                  //   print(
                  //     context.read<AuthenticationService>().signInWithFacebook(),
                  //   );
                  // },
                  ),
              SizedBox(
                height: 10,
              ),
              // CustomButton(
              //   text: "Sign-in using Apple",
              //   icon: Icon(FontAwesomeIcons.apple),
              //   color: Colors.white,
              //   onTap: () {},
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              Text(
                "Need Help?",
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                child: Text(
                  "New to Queen? Sign up now.",
                  style: Theme.of(context).textTheme.headline2,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ),
                  );
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
