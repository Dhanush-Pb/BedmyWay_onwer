import 'package:meta/meta.dart';

@immutable
abstract class FetchMsgsEvent {}

class FetchMessagesEvent extends FetchMsgsEvent {}

class fetchmessages extends FetchMsgsEvent {}
