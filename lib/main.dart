import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:winetopia_app/screens/authentication/index.dart';
import 'services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Winetopia());
}

class Winetopia extends StatelessWidget {
  const Winetopia({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AuthenticationNavigation(),
    );
  }
}
