import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:winetopia_app/services/firebase_authentication_functions.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final User user = Auth().currentUser!;

  Future<void> logOut() async {
    await Auth().signOut();
  }

  Widget _logOutButton() {
    return ElevatedButton(
      onPressed: () {
        logOut();
      },
      child: Text("Log out"),
    );
  }

  Widget _changePasswordButton() {
    return ElevatedButton(
      onPressed: () {
        logOut();
      },
      child: Text("Change password"),
    );
  }

  Widget _ticket(String ticket_number) {
    return QrImageView(data: ticket_number, size: 300);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream:
          FirebaseFirestore.instance
              .collection("Users")
              .doc(user.uid)
              .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        final userData = snapshot.data!.data() as Map<String, dynamic>;

        return Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ticket(userData["ticket_number"]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _logOutButton(),
                  const SizedBox(width: 10),
                  _changePasswordButton(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
