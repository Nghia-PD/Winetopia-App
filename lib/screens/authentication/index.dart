import 'package:flutter/material.dart';
import 'package:winetopia_app/screens/authentication/login.dart';
import 'package:winetopia_app/screens/home/index.dart';
import 'package:winetopia_app/services/firebase_authentication_functions.dart';

class AuthenticationNavigation extends StatefulWidget {
  const AuthenticationNavigation({super.key});

  @override
  State<AuthenticationNavigation> createState() =>
      _AuthenticationNavigationState();
}

class _AuthenticationNavigationState extends State<AuthenticationNavigation> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Index();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
