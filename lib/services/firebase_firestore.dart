import 'package:cloud_firestore/cloud_firestore.dart';

class Db {
  final String uid;

  Db({required this.uid});

  // Firestore ollection reference
  final CollectionReference users = FirebaseFirestore.instance.collection(
    "users",
  );

  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserRecord(uid) async {
    if (uid == null) return null;

    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      return doc;
    } catch (e) {
      print('Error fetching user record: $e');
      return null;
    }
  }
}
