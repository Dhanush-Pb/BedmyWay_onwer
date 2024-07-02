import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotelonwer/model/mesage_model.dart';

class MessageRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(Replymesge message, String userId) async {
    try {
      final reference =
          _firestore.collection('userSide').doc(userId).collection('messeges');
      await reference.add(message.toMap());
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  Future<void> storeReceivedMessage(Replymesge message, String userId) async {
    try {
      final reference =
          _firestore.collection('userSide').doc(userId).collection('messeges');
      await reference.add(message.toMap());
    } catch (e) {
      throw Exception('Failed to store received message: $e');
    }
  }
}
