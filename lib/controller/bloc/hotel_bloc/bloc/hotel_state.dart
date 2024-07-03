// hotel_state.dart

// ignore_for_file: must_be_immutable

part of 'hotel_bloc.dart';

@immutable
abstract class HotelState {}

class HotelInitial extends HotelState {}

class HotelDataAdded extends HotelState {
  String id;
  HotelDataAdded({required this.id});
}

class HotelDataUpdated extends HotelState {
  String id;
  HotelDataUpdated({required this.id});
}

class HotelDataDeleted extends HotelState {}

class HotelDataError extends HotelState {
  final String error;

  HotelDataError({required this.error});
}

class Hoteldataloading extends HotelState {}

class Hotelimageuploded extends HotelState {
  // ignore: prefer_typing_uninitialized_variables
  final downloadurl;
  Hotelimageuploded({
    required this.downloadurl,
  });
}

// ignore: camel_case_types
class hotelimagerro extends HotelState {
  hotelimagerro(String string);
}

class HotelDataFetched extends HotelState {
  // ignore: non_constant_identifier_names
  final List<Map<String, dynamic>> Hotels;
  // ignore: non_constant_identifier_names
  HotelDataFetched({required this.Hotels});
}

class HotelImageReplaced extends HotelState {
  final downloadUrl;

  HotelImageReplaced({required this.downloadUrl});
}

class CoverImageReplaced extends HotelState {
  final downloadUrl;

  CoverImageReplaced({required this.downloadUrl});
}

class PathImageReplaced extends HotelState {
  final downloadUrl;

  PathImageReplaced({required this.downloadUrl});
}

class TourImageReplaced extends HotelState {
  final downloadUrl;

  TourImageReplaced({required this.downloadUrl});
}
