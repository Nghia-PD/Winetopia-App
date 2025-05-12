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

  Widget _topUpButton() {
    return ElevatedButton(
      onPressed: () async {
        print("Top Up!");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Setting().winetopiaBrightPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // wrap content
        children: [
          Text(
            'Top up',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(width: 8),
          Icon(Icons.add_circle, color: Colors.white),
        ],
      ),
    );
  }

  Widget _withdrawButton() {
    return ElevatedButton(
      onPressed: () async {
        print("Withdraw!");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Setting().winetopiaBrightPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // wrap content
        children: [
          Text(
            'Withdraw',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(width: 8),
          Icon(Icons.remove_circle, color: Colors.white),
        ],
      ),
    );
  }

  Widget _balanceContainer() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Setting().winetopiaBrightPurple, width: 2.0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/gold-coin.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gold',
                          style: TextStyle(
                            color: Setting().winetopiaBrightPurple,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
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
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/silver-coin.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Silver',
                          style: TextStyle(
                            color: Setting().winetopiaBrightPurple,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  '5',
                  style: TextStyle(
                    color: Setting().winetopiaBrightPurple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: 40, // same height
                  child: _topUpButton(),
                ),
              ),
              SizedBox(width: 50),
              Expanded(child: SizedBox(height: 40, child: _withdrawButton())),
            ],
          ),
        ],
      ),
    );
  }

  final GlobalKey _walletKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
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
        //final userData = snapshot.data!.data() as Map<String, dynamic>;

        return Container(
          key: _walletKey,
          decoration: BoxDecoration(color: Colors.white),
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
              SizedBox(height: 10),
              _balanceContainer(),
            ],
          ),
        );
      },
    );
  }
}
