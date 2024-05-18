// hotel_state.dart

part of 'hotel_bloc.dart';

@immutable
abstract class HotelState {}

class HotelInitial extends HotelState {}

class HotelDataAdded extends HotelState {
  String id;
  HotelDataAdded({required this.id});
}

// ignore: must_be_immutable
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
