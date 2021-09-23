import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'custom_snack_bar.dart';

class Authentication {
  static Future<FirebaseApp> initializeFirebase() async {
    return await Firebase.initializeApp();
  }

  static bool isSignedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  static StreamSubscription subscribeToAuthChanges(Function(User?) callback) {
    return FirebaseAuth.instance
        .authStateChanges()
        .listen(callback);
  }

  /// signInWithGoogle code based on CodeMagic article: Google Sign-In & Firebase Authentication Using Flutter
  /// Date: Sep 30, 2020 (no author name given)
  /// Article: https://blog.codemagic.io/firebase-authentication-google-sign-in-using-flutter/
  static Future<void> signInWithGoogle({required BuildContext context}) async {
    if (isSignedIn()) {
      return;
    }

    FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        await auth.signInWithCredential(credential);
        showInfoSnackBar("Logged in", context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential' || e.code == 'invalid-credential') {
          showErrorSnackBar("Error occurred while accessing credentials. Try again.", context);
        }
      } catch (e) {
        showErrorSnackBar("Error occurred using Google Sign-In. Try again.", context);
      }
    }
  }

  /// signOut code based on CodeMagic article: Google Sign-In & Firebase Authentication Using Flutter
  /// Date: Sep 30, 2020 (no author name given)
  /// Article: https://blog.codemagic.io/firebase-authentication-google-sign-in-using-flutter/
  static Future<void> signOut({required BuildContext context}) async {
    if (!isSignedIn()) {
      return;
    }

    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      showInfoSnackBar("Logged out", context);
    } catch (e) {
      showErrorSnackBar("Error signing out. Try again.", context);
    }
  }
}
