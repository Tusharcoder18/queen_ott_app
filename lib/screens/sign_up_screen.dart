
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:queen_ott_app/models/profile.dart';
import 'package:queen_ott_app/services/add_series_services.dart';
import 'package:queen_ott_app/services/auth_service.dart';
import 'package:queen_ott_app/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/screens/user_home_screen.dart';
import 'package:queen_ott_app/services/upload_service.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _emailPhone;
  String _password;
  String _confirmPassword;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onRegister(AuthBase auth) async {
    await auth.createUserWithEmailAndPassword(_emailPhone, _password);
    await auth.setUserData(
      ProfileModel(
          userId: auth.userId(), emailId: _emailPhone, subscribed: false),
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

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
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Form(
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
                          onChanged: (String value) {
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
                            labelText: "Confirm Password",
                          ),
                          // ignore: missing_return
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Password is Required";
                            } else if (_password != _confirmPassword) {
                              return "Password did not match";
                            }
                          },
                          onChanged: (String value) {
                            _confirmPassword = value;
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
                          if (_password == _confirmPassword) {
                            Provider.of<UploadService>(context, listen: false)
                                .getEmailID(emailId: _emailPhone);
                            Provider.of<AddSeriesServices>(
                              context,
                              listen: false,
                            ).getEmailId(email: _emailPhone);
                            _onRegister(auth);
                          } else {
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
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Sign up',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ],
                        ),
                        textColor: Colors.white,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Need Help?",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        child: Text(
                          "Already a user? Sign in now.",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
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
            ),
          ],
        ),
      ),
    );
  }
}
