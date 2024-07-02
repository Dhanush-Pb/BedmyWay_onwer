part of 'scoketmsg_bloc.dart';

@immutable
abstract class ScoketmsgEvent {}

class SendMessageEvent extends ScoketmsgEvent {
  final Replymesge message;
  final String userId;

  SendMessageEvent({required this.message, required this.userId});
}

class ReceiveMessageEvent extends ScoketmsgEvent {
  final Replymesge message;
  final String userId;

  ReceiveMessageEvent({required this.message, required this.userId});
}
