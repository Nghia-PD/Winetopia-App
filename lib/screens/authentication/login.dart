import 'package:flutter/material.dart';
import 'package:winetopia_app/services/firebase_authentication_functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = '';
  bool isLogin = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    await Auth().signInWithEmailAndPassword(
      _controllerEmail.text,
      _controllerPassword.text,
    );
  }

  Widget _title() {
    return const Text("Winetopia 2025");
  }

  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () {
        signInWithEmailAndPassword();
      },
      child: Text("Log In"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _title()),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField("Email", _controllerEmail),
            _entryField("Password", _controllerPassword),
            _errorMessage(),
            _submitButton(),
          ],
        ),
      ),
    );
  }
}
