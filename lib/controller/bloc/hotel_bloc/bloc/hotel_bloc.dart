// // ignore_for_file: unnecessary_cast

// import 'dart:developer';
// import 'dart:typed_data';
// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart' as Firebase_Storage;
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:hotelonwer/controller/bloc/auth_bloc.dart';
// import 'package:meta/meta.dart';

// part 'hotel_event.dart';
// part 'hotel_state.dart';

// String collectionid = '';

// class HotelBloc extends Bloc<HotelEvent, HotelState> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final UserId = FirebaseAuth.instance.currentUser!.uid;
//   HotelBloc() : super(HotelInitial()) {
//     on<HotelEvent>((event, emit) async {
//       if (event is AddHotelData) {
//         await _addHotelData(event.data, emit);
//       } else if (event is UpdateHotelData) {
//         await _updateHotelData(event.data, event.id, emit);
//       } else if (event is DeleteHotelData) {
//         await _deleteHotelData(event.dataId, emit);
//       } else if (event is UploadHotelImage) {
//         await _uploadImagesToStorage(event.imageData, emit);
//       } else if (event is FetchDataEvent) {
//         await gethoteldetails(emit);
//       } else if (event is Uploadtouriamges) {
//         await _uploadTourImages(event.tourimages, emit);
//       } else if (event is Uploadcoverimages) {
//         await _uploadCoverImages(event.coverimaged, emit);
//       } else if (event is Uploadpathimages) {
//         await _uploadPathImages(event.pathimages, emit);
//       }
//     });
//   }
// //! ADD HOTEL DATA
//   Future<void> _addHotelData(
//       Map<String, dynamic> data, Emitter<HotelState> emit) async {
//     try {
//       emit(Hoteldataloading());
//       final reference =
//           _firestore.collection('users').doc(UserId).collection('hoteldata');
//       final docRef = await reference.add(data);
//       collectionid = docRef.id;
//       // DocumentReference<Map<String, dynamic>> a =
//       //     await _firestore.collection('hoteldata').add(data);
//       // collectionid = a.id;
//       emit(HotelDataAdded(id: collectionid));
//     } catch (e) {
//       emit(HotelDataError(error: e.toString()));
//     }
//   }

// //! UPDATE THE DATA
//   Future<void> _updateHotelData(
//       Map<String, dynamic> data, String id, Emitter<HotelState> emit) async {
//     try {
//       emit(Hoteldataloading());
//       await _firestore.collection('hoteldata').doc(id).update(data);
//       emit(HotelDataUpdated(id: id));
//     } catch (e) {
//       emit(HotelDataError(error: e.toString()));
//     }
//   }

// //! DELETE THE DATA
//   Future<void> _deleteHotelData(String dataId, Emitter<HotelState> emit) async {
//     try {
//       emit(Hoteldataloading());
//       await _firestore.collection('hoteldata').doc(dataId).delete();
//       emit(HotelDataDeleted());
//     } catch (e) {
//       emit(HotelDataError(error: e.toString()));
//     }
//   }

// //! UPLOAD IMAGES TO STORAGE AND THAT ASSING TO IMAGE LIST
//   Future<void> _uploadImagesToStorage(
//       List<Uint8List> imageData, Emitter<HotelState> emit) async {
//     try {
//       emit(Hoteldataloading());
//       List<String> downloadUrls = [];

//       for (var img in imageData) {
//         var imageName =
//             'hotel_images_${DateTime.now().microsecondsSinceEpoch}.jpg';
//         var storageRef = FirebaseStorage.instance.ref().child(imageName);
//         final metadata = SettableMetadata(contentType: 'image/jpeg');

//         var uploadTask = storageRef.putData(img, metadata);
//         var snapshot = await uploadTask.whenComplete(() {});
//         var downloadUrl = await snapshot.ref.getDownloadURL();

//         downloadUrls.add(downloadUrl);
//       }

//       DocumentReference docRef =
//           _firestore.collection('hoteldata').doc(collectionid);
//       await docRef.update({'images': downloadUrls});
//       emit(Hotelimageuploded(downloadurl: downloadUrls));
//     } catch (e) {
//       emit(hotelimagerro(e.toString()));
//     }
//   }

// //! GET THE HOTEL DATA
//   Future<void> gethoteldetails(Emitter<HotelState> emit) async {
//     log('called hotel booking event');
//     try {
//       emit(Hoteldataloading());
//       final snapshot =
//           await FirebaseFirestore.instance.collection('hoteldata').get();
//       if (snapshot.docs.isNotEmpty) {
//         List<Map<String, dynamic>> hotels = snapshot.docs.map((doc) {
//           Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//           data['id'] = doc.id;
//           return data;
//         }).toList();
//         emit(HotelDataFetched(Hotels: hotels));
//       }
//     } catch (e) {
//       emit(HotelDataError(error: e.toString()));
//     }
//   }
// //! UPLOAD TOURIST IMAGES TO THE STORAGE AND ASSING TO THE TOURIST IAMAGES LIST

//   Future<void> _uploadTourImages(
//       List<Uint8List> tourImages, Emitter<HotelState> emit) async {
//     try {
//       emit(Hoteldataloading());
//       List<String> tourImageUrls = [];

//       for (var img in tourImages) {
//         var imageName =
//             'tour_images_${DateTime.now().microsecondsSinceEpoch}.jpg';
//         var storageRef = FirebaseStorage.instance.ref().child(imageName);
//         final metadata = SettableMetadata(contentType: 'image/jpeg');

//         var uploadTask = storageRef.putData(img, metadata);
//         var snapshot = await uploadTask.whenComplete(() {});
//         var downloadUrl = await snapshot.ref.getDownloadURL();

//         tourImageUrls.add(downloadUrl);
//       }

//       DocumentReference docRef =
//           _firestore.collection('hoteldata').doc(collectionid);
//       await docRef.update({'tourimage': tourImageUrls});

//       emit(Hotelimageuploded(downloadurl: tourImageUrls));
//     } catch (e) {
//       emit(HotelDataError(error: e.toString()));
//     }
//   }

// //! UPLOAD COVER IMAGES TO THE STORAGE AND ASSING TO THE COVER IMAGE LIST
//   Future<void> _uploadCoverImages(
//       List<Uint8List> coverImages, Emitter<HotelState> emit) async {
//     try {
//       emit(Hoteldataloading());
//       List<String> coverImageUrls = [];

//       for (var img in coverImages) {
//         var imageName =
//             'cover_images_${DateTime.now().microsecondsSinceEpoch}.jpg';
//         var storageRef = FirebaseStorage.instance.ref().child(imageName);
//         final metadata = SettableMetadata(contentType: 'image/jpeg');

//         var uploadTask = storageRef.putData(img, metadata);
//         var snapshot = await uploadTask.whenComplete(() {});
//         var downloadUrl = await snapshot.ref.getDownloadURL();

//         coverImageUrls.add(downloadUrl);
//       }

//       DocumentReference docRef =
//           _firestore.collection('hoteldata').doc(collectionid);
//       await docRef.update({'coverimage': coverImageUrls});

//       emit(Hotelimageuploded(downloadurl: coverImageUrls));
//     } catch (e) {
//       emit(HotelDataError(error: e.toString()));
//     }
//   }

// //! UPLOAD PATH IMAGE AND  ASSING TO THE PATHIMAGES LIST
//   Future<void> _uploadPathImages(
//       List<Uint8List> pathImages, Emitter<HotelState> emit) async {
//     try {
//       emit(Hoteldataloading());
//       List<String> pathImageUrls = [];

//       for (var img in pathImages) {
//         var imageName =
//             'path_images_${DateTime.now().microsecondsSinceEpoch}.jpg';
//         var storageRef = FirebaseStorage.instance.ref().child(imageName);
//         final metadata = SettableMetadata(contentType: 'image/jpeg');

//         var uploadTask = storageRef.putData(img, metadata);
//         var snapshot = await uploadTask.whenComplete(() {});
//         var downloadUrl = await snapshot.ref.getDownloadURL();

//         pathImageUrls.add(downloadUrl);
//       }

//       DocumentReference docRef =
//           _firestore.collection('hoteldata').doc(collectionid);
//       await docRef.update({'pathimage': pathImageUrls});

//       emit(Hotelimageuploded(downloadurl: pathImageUrls));
//     } catch (e) {
//       emit(HotelDataError(error: e.toString()));
//     }
//   }
// }

// ignore_for_file: unnecessary_cast
import 'dart:developer';

import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

part 'hotel_event.dart';
part 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _collectionid = '';
  HotelBloc() : super(HotelInitial()) {
    on<HotelEvent>((event, emit) async {
      if (event is AddHotelData) {
        await _addHotelData(event.data, emit);
      } else if (event is UpdateHotelData) {
        await _updateHotelData(event.data, event.id, emit);
      } else if (event is DeleteHotelData) {
        await _deleteHotelData(event.dataId, emit);
      } else if (event is UploadHotelImage) {
        await _uploadImagesToStorage(event.imageData, emit);
      } else if (event is FetchDataEvent) {
        await _getHotelData(emit);
      } else if (event is Uploadtouriamges) {
        await _uploadTourImages(event.tourimages, emit);
      } else if (event is Uploadcoverimages) {
        await _uploadCoverImages(event.coverimaged, emit);
      } else if (event is Uploadpathimages) {
        await _uploadPathImages(event.pathimages, emit);
      } else if (event is Repalaceimages) {
        await _replaceHotelImages(event.roomimages, event.id, emit);
      } else if (event is ReplaceTourimage) {
        await _replaceTourImages(event.tourimage, event.id, emit);
      } else if (event is ReplaceCoverimages) {
        await _replaceCoverimage(event.Coverimages, event.id, emit);
      } else if (event is ReplacePathimage) {
        await _replacePathmage(event.Pathimages, event.id, emit);
      }
    });
  }

  String get hotelDocumentId => _collectionid;

  Future<String> _getUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-not-authenticated',
        message: 'User not authenticated',
      );
    }
    return user.uid;
  }

  Future<void> _addHotelData(
      Map<String, dynamic> data, Emitter<HotelState> emit) async {
    try {
      emit(Hoteldataloading());
      final String userId = await _getUserId();
      log('Attempting to add hotel data for user: $userId');
      final reference =
          _firestore.collection('users').doc(userId).collection('hoteldata');
      final docRef = await reference.add(data);
      _collectionid = docRef.id;
      log('Hotel data added with ID: $_collectionid');
      emit(HotelDataAdded(id: docRef.id));
    } catch (e) {
      log('error: ${e.toString()}');
      emit(HotelDataError(error: e.toString()));
    }
  }

  Future<void> _updateHotelData(
      Map<String, dynamic> data, String id, Emitter<HotelState> emit) async {
    try {
      emit(Hoteldataloading());
      final String userId = await _getUserId();
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('hoteldata')
          .doc(id)
          .update(data);
      emit(HotelDataUpdated(id: id));
    } catch (e) {
      emit(HotelDataError(error: e.toString()));
    }
  }

  Future<void> _deleteHotelData(String dataId, Emitter<HotelState> emit) async {
    try {
      emit(Hoteldataloading());
      final String userId = await _getUserId();
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('hoteldata')
          .doc(dataId)
          .delete();
      emit(HotelDataDeleted());
    } catch (e) {
      emit(HotelDataError(error: e.toString()));
    }
  }

  Future<void> _uploadImagesToStorage(
      List<Uint8List> imageData, Emitter<HotelState> emit) async {
    try {
      emit(Hoteldataloading());
      List<String> downloadUrls = [];
      final String userId = await _getUserId();

      for (var img in imageData) {
        var imageName =
            'hotel_images_${DateTime.now().microsecondsSinceEpoch}.jpg';
        var storageRef = FirebaseStorage.instance.ref().child(imageName);
        final metadata = SettableMetadata(contentType: 'image/jpeg');

        var uploadTask = storageRef.putData(img, metadata);
        var snapshot = await uploadTask;
        var downloadUrl = await snapshot.ref.getDownloadURL();

        downloadUrls.add(downloadUrl);
      }

      DocumentReference docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('hoteldata')
          .doc(_collectionid);
      await docRef.update({'images': downloadUrls});
      emit(Hotelimageuploded(downloadurl: downloadUrls));
    } catch (e) {
      emit(HotelDataError(error: e.toString()));
    }
  }

  Future<void> _getHotelData(Emitter<HotelState> emit) async {
    log('Fetching hotel data...');
    try {
      final String userId = await _getUserId();
      QuerySnapshot hotelSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('hoteldata')
          .get();

      if (hotelSnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> hotels = hotelSnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return data;
        }).toList();
        emit(HotelDataFetched(Hotels: hotels));
      } else {
        emit(HotelDataError(error: 'No hotel data found'));
      }
    } catch (e) {
      emit(HotelDataError(error: e.toString()));
    }
  }

  Future<void> _uploadTourImages(
      List<Uint8List> tourImages, Emitter<HotelState> emit) async {
    try {
      emit(Hoteldataloading());
      List<String> tourImageUrls = [];
      final String userId = await _getUserId();

      for (var img in tourImages) {
        var imageName =
            'tour_images_${DateTime.now().microsecondsSinceEpoch}.jpg';
        var storageRef = FirebaseStorage.instance.ref().child(imageName);
        final metadata = SettableMetadata(contentType: 'image/jpeg');

        var uploadTask = storageRef.putData(img, metadata);
        var snapshot = await uploadTask;
        var downloadUrl = await snapshot.ref.getDownloadURL();

        tourImageUrls.add(downloadUrl);
      }

      DocumentReference docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('hoteldata')
          .doc(_collectionid);
      await docRef.update({'tourimage': tourImageUrls});

      emit(Hotelimageuploded(downloadurl: tourImageUrls));
    } catch (e) {
      emit(HotelDataError(error: e.toString()));
    }
  }

  Future<void> _uploadCoverImages(
      List<Uint8List> coverImages, Emitter<HotelState> emit) async {
    try {
      emit(Hoteldataloading());
      List<String> coverImageUrls = [];
      final String userId = await _getUserId();

      for (var img in coverImages) {
        var imageName =
            'cover_images_${DateTime.now().microsecondsSinceEpoch}.jpg';
        var storageRef = FirebaseStorage.instance.ref().child(imageName);
        final metadata = SettableMetadata(contentType: 'image/jpeg');

        var uploadTask = storageRef.putData(img, metadata);
        var snapshot = await uploadTask;
        var downloadUrl = await snapshot.ref.getDownloadURL();

        coverImageUrls.add(downloadUrl);
      }

      DocumentReference docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('hoteldata')
          .doc(_collectionid);
      await docRef.update({'coverimage': coverImageUrls});

      emit(Hotelimageuploded(downloadurl: coverImageUrls));
    } catch (e) {
      emit(HotelDataError(error: e.toString()));
    }
  }

  Future<void> _uploadPathImages(
      List<Uint8List> pathImages, Emitter<HotelState> emit) async {
    try {
      emit(Hoteldataloading());
      List<String> pathImageUrls = [];
      final String userId = await _getUserId();

      for (var img in pathImages) {
        var imageName =
            'path_images_${DateTime.now().microsecondsSinceEpoch}.jpg';
        var storageRef = FirebaseStorage.instance.ref().child(imageName);
        final metadata = SettableMetadata(contentType: 'image/jpeg');

        var uploadTask = storageRef.putData(img, metadata);
        var snapshot = await uploadTask;
        var downloadUrl = await snapshot.ref.getDownloadURL();

        pathImageUrls.add(downloadUrl);
      }

      DocumentReference docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('hoteldata')
          .doc(_collectionid);
      await docRef.update({'pathimage': pathImageUrls});

      emit(Hotelimageuploded(downloadurl: pathImageUrls));
    } catch (e) {
      emit(HotelDataError(error: e.toString()));
    }
  }

  Future<void> _replaceHotelImages(List<Uint8List> roomImages,
      String documentId, Emitter<HotelState> emit) async {
    try {
      emit(Hoteldataloading());
      List<String> roomImageUrls = [];
      final String userId = await _getUserId();

      for (var img in roomImages) {
        var imageName =
            'room_images_${DateTime.now().microsecondsSinceEpoch}.jpg';
        var storageRef = FirebaseStorage.instance.ref().child(imageName);
        final metadata = SettableMetadata(contentType: 'image/jpeg');

        var uploadTask = storageRef.putData(img, metadata);
        var snapshot = await uploadTask;
        var downloadUrl = await snapshot.ref.getDownloadURL();

        roomImageUrls.add(downloadUrl);
      }

      DocumentReference docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('hoteldata')
          .doc(documentId);
      await docRef.update({'images': roomImageUrls});

      emit(Hotelimageuploded(downloadurl: roomImageUrls));
    } catch (e) {
      emit(HotelDataError(error: e.toString()));
    }
  }

  Future<void> _replaceTourImages(List<Uint8List> tourImages, String documentId,
      Emitter<HotelState> emit) async {
    try {
      emit(Hoteldataloading());

      final String userId = await _getUserId();
      List<String> tourImageUrls = [];

      for (var img in tourImages) {
        var imageName =
            'tour_image_${DateTime.now().microsecondsSinceEpoch}.jpg';
        var storageRef = FirebaseStorage.instance.ref().child(imageName);
        final metadata = SettableMetadata(contentType: 'image/jpeg');

        var uploadTask = storageRef.putData(img, metadata);
        var snapshot = await uploadTask;
        var downloadUrl = await snapshot.ref.getDownloadURL();

        tourImageUrls.add(downloadUrl);
      }

      DocumentReference docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('hoteldata')
          .doc(documentId);
      await docRef.update({'tourimage': tourImageUrls});

      emit(TourImageReplaced(downloadUrl: tourImageUrls));
    } catch (e) {
      emit(HotelDataError(error: e.toString()));
    }
  }

  Future<void> _replaceCoverimage(List<Uint8List> coverImages,
      String documentId, Emitter<HotelState> emit) async {
    try {
      emit(Hoteldataloading());

      final String userId = await _getUserId();
      List<String> Coverimageurl = [];

      for (var img in coverImages) {
        var imageName =
            'cover_image_${DateTime.now().microsecondsSinceEpoch}.jpg';
        var storageRef = FirebaseStorage.instance.ref().child(imageName);
        final metadata = SettableMetadata(contentType: 'image/jpeg');

        var uploadTask = storageRef.putData(img, metadata);
        var snapshot = await uploadTask;
        var downloadUrl = await snapshot.ref.getDownloadURL();

        Coverimageurl.add(downloadUrl);
      }

      DocumentReference docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('hoteldata')
          .doc(documentId);
      await docRef.update({'coverimage': Coverimageurl});

      emit(TourImageReplaced(downloadUrl: Coverimageurl));
    } catch (e) {
      emit(HotelDataError(error: e.toString()));
    }
  }

  Future<void> _replacePathmage(List<Uint8List> pathhImages, String documentId,
      Emitter<HotelState> emit) async {
    try {
      emit(Hoteldataloading());

      final String userId = await _getUserId();
      List<String> pathhImagesUrl = [];

      for (var img in pathhImages) {
        var imageName =
            'Path_image_${DateTime.now().microsecondsSinceEpoch}.jpg';
        var storageRef = FirebaseStorage.instance.ref().child(imageName);
        final metadata = SettableMetadata(contentType: 'image/jpeg');

        var uploadTask = storageRef.putData(img, metadata);
        var snapshot = await uploadTask;
        var downloadUrl = await snapshot.ref.getDownloadURL();

        pathhImagesUrl.add(downloadUrl);
      }

      DocumentReference docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('hoteldata')
          .doc(documentId);
      await docRef.update({'pathimage': pathhImagesUrl});

      emit(TourImageReplaced(downloadUrl: pathhImagesUrl));
    } catch (e) {
      emit(HotelDataError(error: e.toString()));
    }
  }
}
