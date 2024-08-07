// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotelonwer/controller/fetchmsg/bloc/fetch_msgs_event.dart';
import 'package:hotelonwer/controller/fetchmsg/bloc/fetch_msgs_state.dart';

class FetchMsgsBloc extends Bloc<FetchMsgsEvent, FetchMsgsState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FetchMsgsBloc() : super(FetchMsgsInitial()) {
    on<FetchMsgsEvent>((event, emit) async {
      if (event is fetchmessages) {
        await Messagesfucntion(event, emit);
      }
    });
  }

  Future<void> Messagesfucntion(
      fetchmessages event, Emitter<FetchMsgsState> emit) async {
    try {
      emit(MessagesLoading());
      final String userId = await _getUserId();
      QuerySnapshot hotelSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('hoteldata')
          .get();

      QuerySnapshot userSnapshot =
          await _firestore.collection('userSide').get();

      List<Map<String, dynamic>> messages = [];
      Set<String> uniqueMessages =
          {}; // To track unique user-hotel combinations

      for (var userDoc in userSnapshot.docs) {
        print('Fetching messages for receiverId ID: ${userDoc.id}');

        QuerySnapshot messageSnapshot = await _firestore
            .collection('userSide')
            .doc(userDoc.id)
            .collection('messeges')
            .get();

        for (var messageDoc in messageSnapshot.docs) {
          Map<String, dynamic> data = messageDoc.data() as Map<String, dynamic>;
          data['id'] = messageDoc.id;
          String hotelId = messageDoc['reciverId'];
          String uniqueKey = '${userDoc.id}_$hotelId';

          for (var userHotel in hotelSnapshot.docs) {
            if (hotelId == userHotel.id) {
              if (!uniqueMessages.contains(uniqueKey)) {
                // print('HALO');
                ///print(uniqueKey);
                messages.add(data);
                uniqueMessages.add(uniqueKey);
                data.forEach((key, value) {
                  print('$key: $value');
                });
              }
              break;
            }
          }
        }
      }

      if (messages.isNotEmpty) {
        emit(MessagesLoaded(messages: messages));
      } else {
        emit(MessagesError(error: 'No messages found'));
      }
    } catch (e) {
      emit(MessagesError(error: e.toString()));
    }
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
}
