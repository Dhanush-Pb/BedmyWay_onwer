// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'revanue_event.dart';
part 'revanue_state.dart';

class RevanueBloc extends Bloc<RevanueEvent, RevanueState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RevanueBloc() : super(RevanueInitial()) {
    on<RevanueEvent>((event, emit) async {
      if (event is Revenuefetch) {
        await fetchRevenueData(event, emit);
      }
    });
  }
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

  Future<void> fetchRevenueData(
    Revenuefetch event,
    Emitter<RevanueState> emit,
  ) async {
    emit(Bookdataloading());

    try {
      final String userId = await _getUserId();
      QuerySnapshot hotelSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('hoteldata')
          .get();

      //! section of the bokking details fetching area
      QuerySnapshot userSnapshot =
          await _firestore.collection('userSide').get();
      log('doc count is => ${userSnapshot.docs.length}');

      List<Map<String, dynamic>> hotels = [];

      for (var userDoc in userSnapshot.docs) {
        print('Fetching data for booking ID: ${userDoc.id}');

        QuerySnapshot bookedhotelSnapshot = await _firestore
            .collection('userSide')
            .doc(userDoc.id)
            .collection('bookedhotels')
            .get();

        for (var hotelDoc in bookedhotelSnapshot.docs) {
          //log(hotelDoc['hotelDocId']);
          Map<String, dynamic> data = hotelDoc.data() as Map<String, dynamic>;
          data['id'] = hotelDoc.id;

          for (var userhotel in hotelSnapshot.docs) {
            if (hotelDoc['hotelDocId'] == userhotel.id) {
              hotels.add(data);
              // log(data['hotelDocId']);
            }
          }

          // log('Hotel ID: ${data['hotelDocId']}');
          // data.forEach((key, value) {
          //   log('$key: $value');
          // });
        }
      }

      if (hotels.isNotEmpty) {
        emit(BookedDatafetched(hotels: hotels));
      } else {
        emit(BookdataError(error: 'No booking data found'));
      }
    } catch (e) {
      emit(BookdataError(error: e.toString()));
    }
  }
}
