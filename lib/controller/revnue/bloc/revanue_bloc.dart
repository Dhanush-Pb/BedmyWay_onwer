// ignore_for_file: unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'revanue_event.dart';
part 'revanue_state.dart';

class RevanueBloc extends Bloc<RevanueEvent, RevanueState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RevanueBloc() : super(RevanueInitial()) {
    on<Revenuefetch>(_onRevenueFetch);
  }
//! HERE IS THE BOOKING DATA FETCHING
  Future<void> _onRevenueFetch(
      Revenuefetch event, Emitter<RevanueState> emit) async {
    QuerySnapshot<Map<String, dynamic>> bookuserSnapshot =
        await _firestore.collection("booking").get();

    List<Map<String, dynamic>> bookedHotels =
        bookuserSnapshot.docs.map((doc) => doc.data()).toList();
  }
}
