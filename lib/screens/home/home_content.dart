import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:winetopia_app/services/firebase_authentication_functions.dart';

class HomeContent extends StatefulWidget {
  HomeContent({super.key});
  final User? user = Auth().currentUser;

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Text("Home page"),
    );
  }
}
