import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:winetopia_app/screens/authentication/index.dart';
import 'package:winetopia_app/shares/nfc_state.dart';
import 'package:winetopia_app/shares/setting.dart';
import 'services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [], // Hides both status and navigation bars
  );
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider<NfcState>(create: (_) => NfcState())],
      child: const Winetopia(),
    ),
  );
}

class Winetopia extends StatelessWidget {
  const Winetopia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Setting().otherComponentColor,
        ),
      ),
      home: const AuthenticationNavigation(),
    );
  }
}
