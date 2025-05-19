import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final String uid;

  FirestoreService({required this.uid});

  // stream data of current attendee
  Stream<DocumentSnapshot> get attendeeDataStream {
    return FirebaseFirestore.instance
        .collection("Attendees")
        .doc(uid)
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> updateBalance(
    String wineId,
  ) async {
    DocumentSnapshot<Map<String, dynamic>> attendeeDoc =
        await FirebaseFirestore.instance.collection("Attendees").doc(uid).get();

    DocumentSnapshot<Map<String, dynamic>> wineDoc =
        await FirebaseFirestore.instance.collection("Wines").doc(wineId).get();

    final currency = wineDoc["currency"];
    final exhibitorId = wineDoc["exhibitorId"];
    final price = wineDoc["price"];
    DocumentSnapshot<Map<String, dynamic>> exhibitorDoc =
        await FirebaseFirestore.instance
            .collection("Exhibitors")
            .doc(exhibitorId)
            .get();

    if (currency == "goldCoin") {
      final goldBalanceAttendee = attendeeDoc["goldCoin"];
      final goldBalanceExhibitor = exhibitorDoc["goldCoin"];
      if (goldBalanceAttendee < price) {
        throw InsufficientBalanceException(
          "You don't have enough gold coin. Please top up!",
        );
      }
      FirebaseFirestore.instance.collection("Attendees").doc(uid).update({
        "goldCoin": goldBalanceAttendee - price,
      });
      FirebaseFirestore.instance
          .collection("Exhibitors")
          .doc(exhibitorId)
          .update({"goldCoin": goldBalanceExhibitor + price});
    } else {
      final silverBalanceAttendee = attendeeDoc["silverCoin"];
      final silverBalanceExhibitor = exhibitorDoc["silverCoin"];
      if (silverBalanceAttendee < price) {
        throw InsufficientBalanceException(
          "You don't have enough silver coin. Please top up!",
        );
      }
      FirebaseFirestore.instance.collection("Attendees").doc(uid).update({
        "silverCoin": silverBalanceAttendee - price,
      });

      FirebaseFirestore.instance
          .collection("Exhibitors")
          .doc(exhibitorId)
          .update({"silverCoin": silverBalanceExhibitor + price});
    }

    await FirebaseFirestore.instance.collection("Transactions").doc().set({
      "attendeeId": uid,
      "amount": price,
      "currency": currency,
      "exhibitorId": exhibitorId,
      "exhibitorName": exhibitorDoc["name"],
      "purchaseTime": DateTime.now(),
      "wineId": wineId,
      "wineName": wineDoc["name"],
    });

    return wineDoc;
  }
}

class InsufficientBalanceException implements Exception {
  final String message;
  InsufficientBalanceException(this.message);

  @override
  String toString() => message;
}
