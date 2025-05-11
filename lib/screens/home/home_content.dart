import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:winetopia_app/services/firebase_authentication_functions.dart';
import 'package:winetopia_app/shares/loading.dart';
import 'package:winetopia_app/shares/setting.dart';
import 'package:winetopia_app/shares/widgets.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final User user = Auth().currentUser!;
  Widget _balanceContainer() {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Setting().winetopiaBrightPurple, // Border color
          width: 2.0, // Border width
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: <Widget>[
          Text(
            'Gold',
            style: TextStyle(
              color: Setting().winetopiaBrightPurple,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          Text(
            '0',
            style: TextStyle(
              color: Setting().winetopiaBrightPurple,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream:
          FirebaseFirestore.instance
              .collection("Attendees")
              .doc(user.uid)
              .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }
        final userData = snapshot.data!.data() as Map<String, dynamic>;

        return Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(
            left: Setting().yPaddingInHome,
            right: Setting().yPaddingInHome,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Widgets().title("Wallet"),
              ),
              SizedBox(height: 30),
              _balanceContainer(),
            ],
          ),
        );
      },
    );
  }
}
