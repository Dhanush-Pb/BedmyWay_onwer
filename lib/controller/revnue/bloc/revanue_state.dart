part of 'revanue_bloc.dart';

@immutable
sealed class RevanueState {}

final class RevanueInitial extends RevanueState {}

final class BookdataError extends RevanueState {
  final String error;

  BookdataError({required this.error});
}

final class Bookdataloading extends RevanueState {}

final class BookedDatafetched extends RevanueState {
  final List<Map<String, dynamic>> hotels;

  BookedDatafetched({required this.hotels});
}
