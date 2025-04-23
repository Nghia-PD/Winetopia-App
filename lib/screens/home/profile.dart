import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:winetopia_app/services/firebase_authentication_functions.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final User? user = Auth().currentUser;

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
      child: Text("Change Password"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: Row(children: <Widget>[_logOutButton(), _changePasswordButton()]),
    );
  }
}
