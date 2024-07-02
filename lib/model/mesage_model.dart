import 'package:cloud_firestore/cloud_firestore.dart';

class Replymesge {
  final String receiverId;
  final String message;
  final String hotelname;
  final Timestamp timestamp;
  final String email;
  final String userid;
  Replymesge({
    required this.userid,
    required this.email,
    required this.message,
    required this.receiverId,
    required this.timestamp,
    required this.hotelname,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userid,
      'senderEmail': email,
      'reciverId': receiverId,
      'Replymessage': message,
      'Replytime': timestamp,
      'Hotelname': hotelname,
      'timestamp': timestamp,
    };
  }
}
