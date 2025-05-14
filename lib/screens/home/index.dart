import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:winetopia_app/models/attendee.dart';
import 'package:winetopia_app/screens/home/event_info.dart';
import 'package:winetopia_app/screens/home/home_content.dart';
import 'package:winetopia_app/screens/home/profile.dart';
import 'package:winetopia_app/services/firebase_auth.dart';
import 'package:winetopia_app/services/firebase_firestore.dart';
import 'package:winetopia_app/shares/loading.dart';
import 'package:winetopia_app/shares/setting.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final User user = AuthService().currentUser!;
    return StreamBuilder<DocumentSnapshot>(
      stream: FirestoreService(uid: user.uid).attendeeDataStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }
        final attendeeData = AttendeeModel.fromMap(
          user.uid,
          snapshot.data!.data() as Map<String, dynamic>,
        );

        final List<Widget> screens = [
          HomeContent(attendeeData: attendeeData),
          Profile(attendeeData: attendeeData),
          const EventInfo(),
        ];
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: AppBar(
              title: Image.asset(
                'assets/images/Winetopia_Logo2024.png',
                height: 75,
                width: 75,
              ),
              backgroundColor: Setting().appBarBackgoundColor,
              scrolledUnderElevation: 0,
            ),
          ),
          body: screens[_currentIndex],
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            indicatorColor: Setting().otherComponentColor,
            selectedIndex: _currentIndex,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: "Home"),
              NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
              NavigationDestination(icon: Icon(Icons.info), label: "Info"),
            ],
          ),
        );
      },
    );
  }
}
