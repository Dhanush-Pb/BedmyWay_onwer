// ignore_for_file: camel_case_types

import 'package:meta/meta.dart';

@immutable
abstract class FetchMsgsEvent {}

class FetchMessagesEvent extends FetchMsgsEvent {}

class fetchmessages extends FetchMsgsEvent {}
