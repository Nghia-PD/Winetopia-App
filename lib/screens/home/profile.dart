import 'package:flutter/material.dart';
import 'package:winetopia_app/models/attendee.dart';
import 'package:winetopia_app/services/firebase_auth.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:winetopia_app/shares/setting.dart';

class Profile extends StatelessWidget {
  final AttendeeModel attendeeData;
  const Profile({required this.attendeeData, super.key});

  Future<void> logOut() async {
    await AuthService().signOut();
  }

  Widget _logOutButton() {
    return ElevatedButton(
      onPressed: () {
        logOut();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Setting().buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Text("Log out", style: TextStyle(color: Setting().textColorLight)),
    );
  }

  Widget _changePasswordButton() {
    return ElevatedButton(
      onPressed: () {
        logOut();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Setting().buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Text(
        "Change Password",
        style: TextStyle(color: Setting().textColorLight),
      ),
    );
  }

  Widget _ticket(String ticketNumber) {
    return QrImageView(data: ticketNumber, size: 300);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Setting().bodyContainerBackgroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ticket(attendeeData.ticketNumber),
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
  }
}
