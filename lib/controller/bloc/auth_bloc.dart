import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotelonwer/model/user_model.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
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
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': event.usermodel.name,
            'email': event.usermodel.email,
            'uid': event.usermodel.Uid,
            'phone': event.usermodel.phone,
            'cratedate': DateTime.now(),
          });
        }
        emit(Authenticated(userCredential.user!.uid));
      } catch (e) {
        emit(AuthenticateError(e.toString()));
      }
    });

    on<logoutevent>((event, emit) async {
      try {
        await FirebaseAuth.instance.signOut();
        emit(UnAuthenticated());
      } catch (e) {
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
        emit(AuthInitial());
      } catch (e) {
        emit(AuthenticateError(e.toString()));
      }
    });
  }
}