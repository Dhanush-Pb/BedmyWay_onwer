part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class checkloginevern extends AuthEvent {}

//login even
class Loginevent extends AuthEvent {
  final String email;
  final String password;
  Loginevent({required this.email, required this.password});
}

//singUp
class singupevent extends AuthEvent {
  final Usermodel usermodel;
  singupevent(Usermodel user, {required this.usermodel});
}

class logoutevent extends AuthEvent {}
