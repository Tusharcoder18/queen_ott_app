import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:queen_ott_app/models/profile.dart';

abstract class AuthBase {
  String userId();
  Stream<User> authStateChanges();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<void> resetPassword(String email);
  Future<void> signOut();
  Future<void> setUserData(ProfileModel profile);
  Future<void> setSubscribed();
  // Stream<bool> isSubscribed();
}

class Auth implements AuthBase {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Stream<User> authStateChanges() => _auth.authStateChanges();

  @override
  Future<User> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _auth.signInWithCredential(
      EmailAuthProvider.credential(email: email, password: password),
    );

    return credential.user;
  }

  @override
  Future<User> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _auth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        final User user = userCredential.user;
        if (user != null) {
          assert(!user.isAnonymous);
          assert(await user.getIdToken() != null);
          final User currentUser = FirebaseAuth.instance.currentUser;
          assert(user.uid == currentUser.uid);
          print('signInWithGoogle succeeded: $user');
        }
        return userCredential.user;
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Missing Google ID Token',
        );
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final fb = FacebookLogin();
    final response = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (response.status) {
      case FacebookLoginStatus.success:
        final accessToken = response.accessToken;
        final userCredential = await _auth.signInWithCredential(
          FacebookAuthProvider.credential(accessToken.token),
        );
        return userCredential.user;
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
          code: 'ERROR_FACEBOOK_LOGIN_FAILED',
          message: response.error.developerMessage,
        );
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FacebookLogin().logOut();
    await _auth.signOut();
  }

  @override
  String userId() {
    return _auth.currentUser.uid;
  }

  @override
  Future<void> setUserData(ProfileModel profile) async {
    await _firestore.collection('Users').doc(userId()).set(
          profile.toMap(),
        );
  }

  @override
  Future<void> setSubscribed() async {
    await _firestore.collection('Users').doc(userId()).update(
      {
        'subscribed': true,
      },
    );
  }

  // @override
  // Stream<bool> isSubscribed() {
  //   print("subCalled");
  //   return _firestore
  //       .collection('Users')
  //       .doc(userId())
  //       .snapshots()
  //       .map((event) => event.data()['subscribed']);
    
  //   // Fetch the subscribed bool from firestore.
  // }
}
