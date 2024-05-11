// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

import 'package:hotelonwer/Screens/loginscrren/loginpage.dart';
import 'package:hotelonwer/coustmfields/Bottm.dart';
import 'package:hotelonwer/coustmfields/transitrion.dart';

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    // Trigger the Google Sign In flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // Handle null user (user canceled sign-in)
      print("User canceled sign-in");
      return;
    }

    // Obtain the GoogleSignInAuthentication object
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the Google Auth credential
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // Check if user credential is null
    if (userCredential.user == null) {
      return;
    }

    // Check if user is not null and navigate accordingly
    if (userCredential.user != null) {
      Navigator.of(context).pushReplacement(buildPageTransition(
          child: BottomNavPage(),
          curve: Curves.easeIn,
          axisDirection: AxisDirection.left));
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Logingpage()),
      );
    }
  } catch (error) {
    // Handle sign-in errors
    print("Error signing in with Google: $error");

    // Navigate to the login page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Logingpage()),
    );
  }
}

Future<void> signOut(BuildContext context) async {
  try {
    // Sign out from Firebase
    await FirebaseAuth.instance.signOut();

    // Sign out from Google Sign-In
    await GoogleSignIn().signOut();

    // Navigate to the login page and remove all previous routes from the stack
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Logingpage()),
      (Route<dynamic> route) => false,
    );
  } catch (error) {
    // Handle sign-out errors
    // ignore: avoid_print
    print("Error signing out: $error");
  }
}
