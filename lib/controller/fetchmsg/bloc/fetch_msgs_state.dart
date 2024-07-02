import 'package:meta/meta.dart';

@immutable
abstract class FetchMsgsState {}

class FetchMsgsInitial extends FetchMsgsState {}

class MessagesLoading extends FetchMsgsState {}

class MessagesLoaded extends FetchMsgsState {
  final List<Map<String, dynamic>> messages;
  MessagesLoaded({required this.messages});
}

class MessagesError extends FetchMsgsState {
  final String error;
  MessagesError({required this.error});
}