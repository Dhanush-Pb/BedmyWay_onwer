// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:developer';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

import 'package:firebase_storage/firebase_storage.dart' as Firebase_Storage;
import 'package:firebase_storage/firebase_storage.dart';

import 'package:meta/meta.dart';

part 'hotel_event.dart';
part 'hotel_state.dart';

String collectionid = '';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  DocumentReference<Map<String, dynamic>>? a;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  HotelBloc() : super(HotelInitial()) {
    on<HotelEvent>((event, emit) async {
      if (event is AddHotelData) {
        await _addHotelData(event.data); // Call method to add data
      } else if (event is UpdateHotelData) {
        await _updateHotelData(
            event.data, event.id); // Call method to update data
      } else if (event is DeleteHotelData) {
        await _deleteHotelData(event.dataId); // Call method to delete data
      } else if (event is UploadHotelImage) {
        await _uploadImagesToStorage(event.imageData);
      } else if (event is FetchDataEvent) {
        await gethoteldetails();
      } else if (event is Uploadtouriamges) {
        await _uploadTourImages(event.tourimages);
      } else if (event is Uploadcoverimages) {
        await _uploadCoverImages(event.coverimaged);
      } else if (event is Uploadpathimages) {
        await _uploadPathImages(event.pathimages);
      }
    });
  }

  Future<void> _addHotelData(Map<String, dynamic> data) async {
    try {
      emit(Hoteldataloading());
      log('dataadding');
      a = await _firestore.collection('hoteldata').add(data);
      collectionid = a!.id;

      emit(HotelDataAdded(id: collectionid));
    } catch (e) {
      emit(HotelDataError(error: e.toString()));
    }
  }

  Future<void> _updateHotelData(Map<String, dynamic> data, String id) async {
    try {
      emit(Hoteldataloading());
      await _firestore.collection('hoteldata').doc(id).update(data);

      emit(HotelDataUpdated(id: id));
    } catch (e) {
      emit(HotelDataError(error: e.toString()));
    }
  }

  Future<void> _deleteHotelData(String dataId) async {
    try {
      emit(Hoteldataloading());
      await _firestore.collection('hoteldata').doc(dataId).delete();

      emit(HotelDataDeleted());
    } catch (e) {
      emit(HotelDataError(error: e.toString()));
    }
  }

  Future<void> _uploadImagesToStorage(List<Uint8List> imageData) async {
    try {
      emit(Hoteldataloading());
      log(collectionid);
      List<String> downloadUrls = [];

      for (var img in imageData) {
        var imageName =
            'hotel_images_${DateTime.now().microsecondsSinceEpoch}.jpg';
        var storageRef = FirebaseStorage.instance.ref().child(imageName);
        final metadata = SettableMetadata(contentType: 'image/jpeg');

        var uploadTask = storageRef.putData(img, metadata);

        // Get download URL after upload completes
        var snapshot = await uploadTask.whenComplete(() {});
        var downloadUrl = await snapshot.ref.getDownloadURL();

        downloadUrls.add(downloadUrl);
      }

      DocumentReference docRef =
          _firestore.collection('hoteldata').doc(collectionid);
      await docRef.update({'images': downloadUrls}); // Update images list
      // Emit success state
      emit(Hotelimageuploded(downloadurl: downloadUrls));
    } catch (e) {
      // Emit error state
      emit(hotelimagerro(e.toString()));
    }
  }

  Future<void> gethoteldetails() async {
    log('called hotel booking event');
    try {
      emit(Hoteldataloading());

      // Listen to the stream of snapshots
      FirebaseFirestore.instance
          .collection('hoteldata')
          .snapshots()
          .listen((QuerySnapshot snapshot) async {
        // Convert the snapshot to hotel data or handle if snapshot is empty
        if (snapshot.docs.isNotEmpty) {
          // Convert QuerySnapshot to List<Map<String, dynamic>> of hotels
          List<Map<String, dynamic>> hotels = snapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();

          emit(HotelDataFetched(Hotels: hotels));
        }
      });
    } catch (e) {
      emit(HotelDataError(error: e.toString()));
    }
  }

  // Add method for uploading and assigning URLs for tour images
  Future<void> _uploadTourImages(List<Uint8List> tourImages) async {
    try {
      emit(Hoteldataloading());
      List<String> tourImageUrls = [];

      for (var img in tourImages) {
        var imageName =
            'tour_images_${DateTime.now().microsecondsSinceEpoch}.jpg';
        var storageRef = FirebaseStorage.instance.ref().child(imageName);
        final metadata = SettableMetadata(contentType: 'image/jpeg');

        var uploadTask = storageRef.putData(img, metadata);

        var snapshot = await uploadTask.whenComplete(() {});
        var downloadUrl = await snapshot.ref.getDownloadURL();

        tourImageUrls.add(downloadUrl);
      }

      // Update tour images list in Firestore
      DocumentReference docRef =
          _firestore.collection('hoteldata').doc(collectionid);
      await docRef.update({'tourimage': tourImageUrls});

      emit(Hotelimageuploded(downloadurl: tourImageUrls));
    } catch (e) {
      emit(HotelDataError(error: e.toString()));
    }
  }

// Add method for uploading and assigning URLs for cover images
  Future<void> _uploadCoverImages(List<Uint8List> coverImages) async {
    try {
      emit(Hoteldataloading());
      List<String> coverImageUrls = [];

      for (var img in coverImages) {
        var imageName =
            'cover_images_${DateTime.now().microsecondsSinceEpoch}.jpg';
        var storageRef = FirebaseStorage.instance.ref().child(imageName);
        final metadata = SettableMetadata(contentType: 'image/jpeg');

        var uploadTask = storageRef.putData(img, metadata);

        var snapshot = await uploadTask.whenComplete(() {});
        var downloadUrl = await snapshot.ref.getDownloadURL();

        coverImageUrls.add(downloadUrl);
      }

      // Update cover images list in Firestore
      DocumentReference docRef =
          _firestore.collection('hoteldata').doc(collectionid);
      await docRef.update({'coverimage': coverImageUrls});

      emit(Hotelimageuploded(downloadurl: coverImageUrls));
    } catch (e) {
      emit(HotelDataError(error: e.toString()));
    }
  }

// Add method for uploading and assigning URLs for path images
  Future<void> _uploadPathImages(List<Uint8List> pathImages) async {
    try {
      emit(Hoteldataloading());
      List<String> pathImageUrls = [];

      for (var img in pathImages) {
        var imageName =
            'path_images_${DateTime.now().microsecondsSinceEpoch}.jpg';
        var storageRef = FirebaseStorage.instance.ref().child(imageName);
        final metadata = SettableMetadata(contentType: 'image/jpeg');

        var uploadTask = storageRef.putData(img, metadata);

        var snapshot = await uploadTask.whenComplete(() {});
        var downloadUrl = await snapshot.ref.getDownloadURL();

        pathImageUrls.add(downloadUrl);
      }

      // Update path images list in Firestore
      DocumentReference docRef =
          _firestore.collection('hoteldata').doc(collectionid);
      await docRef.update({'pathimage': pathImageUrls});

      emit(Hotelimageuploded(downloadurl: pathImageUrls));
    } catch (e) {
      emit(HotelDataError(error: e.toString()));
    }
  }
}
