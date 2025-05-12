import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final String uid;

  FirestoreService({required this.uid});

  // stream data of current attendee
  Stream<DocumentSnapshot> get attendeeData {
    return FirebaseFirestore.instance
        .collection("Attendees")
        .doc(uid)
        .snapshots();
  }
}
