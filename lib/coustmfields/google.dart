import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:hotelonwer/Screens/homepage.dart';
import 'package:hotelonwer/Screens/loginpage.dart';
import 'package:hotelonwer/coustmfields/Bottm.dart';
// Import your login page

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
      print("User credential is null");
      return;
    }

    // Navigate to the home page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => BottomNavPage()),
    );
  } catch (error) {
    // Handle sign-in errors
    print("Error signing in with Google: $error");

    // Navigate to the login page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Logingpage()),
    );
  }
}
