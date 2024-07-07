// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

import 'package:hotelonwer/views/Screens/loginscrren/loginpage.dart';
import 'package:hotelonwer/resources/components/coustmfields/Bottm_page.dart';
import 'package:hotelonwer/resources/components/coustmfields/transitrion.dart';

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // User canceled sign-in
      return;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user == null) {
      // Failed to sign in
      return;
    }

    // Successfully signed in
    Navigator.of(context).pushReplacement(
      buildPageTransition(
        child: BottomNavPage(),
        curve: Curves.easeIn,
        axisDirection: AxisDirection.left,
      ),
    );
  } catch (error) {
    // Handle sign-in error gracefully
    print("Error signing in with Google: $error");

    // Navigate to login page on error
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Logingpage()),
    );
  }
}

Future<void> signOut(BuildContext context) async {
  try {
    // Sign out from Firebase
    await FirebaseAuth.instance.signOut();
    print('Firebase sign-out successful.');

    // Sign out from Google
    await GoogleSignIn().signOut();
    print('Google sign-out successful.');

    // Adding a short delay to ensure sign-out operations are completed
    await Future.delayed(Duration(milliseconds: 500));

    // Ensure all previous routes are removed
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Logingpage()),
      (Route<dynamic> route) => false,
    );
    print('Navigated to login page.');
  } catch (error) {
    print("Error signing out: $error");
  }
}
