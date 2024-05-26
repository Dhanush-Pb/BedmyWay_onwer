// hotel_event.dart

// ignore_for_file: must_be_immutable

part of 'hotel_bloc.dart';

@immutable
abstract class HotelEvent {}

class AddHotelData extends HotelEvent {
  final Map<String, dynamic> data;

  AddHotelData(this.data);
}

class UpdateHotelData extends HotelEvent {
  final Map<String, dynamic> data;
  final String id;
  UpdateHotelData(this.data, {required this.id});
}

class DeleteHotelData extends HotelEvent {
  final String dataId;

  DeleteHotelData(this.dataId);
}

class UploadHotelImage extends HotelEvent {
  List<Uint8List> imageData;

  UploadHotelImage(this.imageData);
}

class Uploadtouriamges extends HotelEvent {
  List<Uint8List> tourimages;
  Uploadtouriamges({required this.tourimages});
}

class Uploadcoverimages extends HotelEvent {
  List<Uint8List> coverimaged;
  Uploadcoverimages({required this.coverimaged});
}

class Uploadpathimages extends HotelEvent {
  List<Uint8List> pathimages;
  Uploadpathimages({required this.pathimages});
}

class Repalaceimages extends HotelEvent {
  List<Uint8List> roomimages;
  final String id;
  Repalaceimages(this.roomimages, this.id);
}

class ReplaceCoverimages extends HotelEvent {
  List<Uint8List> Coverimages;
  final String id;
  ReplaceCoverimages(this.Coverimages, this.id);
}

class ReplacePathimage extends HotelEvent {
  List<Uint8List> Pathimages;
  final String id;
  ReplacePathimage(this.Pathimages, this.id);
}

class ReplaceTourimage extends HotelEvent {
  List<Uint8List> tourimage;
  final String id;
  ReplaceTourimage(this.tourimage, this.id);
}

class FetchDataEvent extends HotelEvent {}
