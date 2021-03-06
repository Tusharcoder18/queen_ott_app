import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebookLogin = FacebookLogin();

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();

    print("User signed out");
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed Up";
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_MAIL_ALREADY_IN_USE') {
          return "Email Already exists";
        }
      }
    }
  }

  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn().catchError((onError) {
        print("Error $onError");
      });
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _firebaseAuth
          .signInWithCredential(credential)
          .catchError((onError) {
        print("Error: $onError");
      });
      final User user = authResult.user;

      if (user != null) {
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final User currentUser = _firebaseAuth.currentUser;
        assert(user.uid == currentUser.uid);

        print('signInWithGoogle succeeded: $user');

        return '$user';
      }
      return null;
    } catch (e) {
      print(e);
      return "Sign In cancelled";
    }
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();

    print("Google User Signed Out");
  }

  Future<String> signInWithFacebook() async {
    final FacebookLoginResult result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.cancelledByUser:
        print("Login Cancelled");
        break;
      case FacebookLoginStatus.error:
        print("Login Error!");
        break;
      case FacebookLoginStatus.loggedIn:
        try {
          final FacebookAccessToken accessToken = result.accessToken;
          AuthCredential credential =
              FacebookAuthProvider.credential(accessToken.token);
          final UserCredential authResult =
              await _firebaseAuth.signInWithCredential(credential);
          final User user = authResult.user;
          return '$user';
        } catch (e) {
          print(e);
        }
        break;
    }
    return null;
  }

  Future<void> signOutFacebook() async {
    await facebookLogin.logOut();

    print("Facebook User Signed Out");
  }
}
