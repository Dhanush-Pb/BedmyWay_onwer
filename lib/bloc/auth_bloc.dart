import 'package:bloc/bloc.dart';

import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:hotelonwer/model/user_model.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    // Check login event
    on<checkloginevern>((event, emit) async {
      User? user;
      try {
        await Future.delayed(const Duration(seconds: 3));
        user = _auth.currentUser;
        if (user != null) {
          emit(Authenticated(user.uid));
        } else {
          emit(UnAuthenticated());
        }
      } catch (e) {
        emit(AuthenticateError(e.toString()));
      }
    });

    // Signup event
    on<singupevent>((event, emit) async {
      emit(Authloadin());
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: event.usermodel.email.toString(),
          password: event.usermodel.password.toString(),
        );
        final User? user = userCredential.user;
        if (user != null) {
          // Here you can add code to store user data in Firestore
          // For example:
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': event.usermodel.name,
            'email': event.usermodel.email,
            'uid': event.usermodel.Uid,
            'phone': event.usermodel.phone,
            'cratedate': DateTime.now(),
            //   // Add other user data fields as needed
          });
        }
        emit(Authenticated(userCredential.user!.uid));
      } catch (e) {
        emit(AuthenticateError(e.toString()));
      }
    });
    on<logoutevent>((event, emit) async {
      try {
        // Perform the logout operation
        await FirebaseAuth.instance.signOut();
        // Emit the UnAuthenticated state to indicate successful logout
        emit(UnAuthenticated());
      } catch (e) {
        // If an error occurs during logout, emit an AuthenticateError state
        emit(AuthenticateError(e.toString()));
      }
    });
    on<Loginevent>((event, emit) async {
      emit(Authloadin());
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        final User? user = userCredential.user;
        if (user != null) {
          emit(Authenticated(user.uid));
        } else {
          emit(UnAuthenticated());
        }
      } catch (e) {
        emit(AuthenticateError(e.toString()));
      }
    });
    on<ForgotPasswordEvent>((event, emit) async {
      emit(Authloadin());
      try {
        await _auth.sendPasswordResetEmail(email: event.email);
        // Password reset email sent successfully
        emit(AuthInitial());
      } catch (e) {
        // Error occurred while sending password reset email
        emit(AuthenticateError(e.toString()));
      }
    });
    on<FetchDataEvent>((event, emit) async {
      emit(Authloadin());
      try {
        final User? user = _auth.currentUser;
        if (user != null) {
          // Fetch user data from Firestore using user ID
          final DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
          if (userDoc.exists) {
            final userData = userDoc.data() as Map<String, dynamic>;
            final userdetails = Usermodel(
              Uid: userData['uid'],

              name: userData['name'],
              email: userData['email'],
              phone: userData['phone'],
              // Add other fields as needed
            );
            emit(UserDataLoadedgeted(userdetails));
          } else {
            emit(AuthenticateError('User data not found'));
          }
        } else {
          emit(UnAuthenticated());
        }
      } catch (e) {
        emit(AuthenticateError(e.toString()));
      }
    });
  }
}
