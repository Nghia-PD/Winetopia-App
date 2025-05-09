import 'package:flutter/material.dart';
import 'package:winetopia_app/services/firebase_authentication_functions.dart';
import 'package:winetopia_app/shares/clip_path.dart';
import 'package:winetopia_app/shares/loading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String errorMessage = '';
  bool isLogin = false;
  bool loading = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Widget _entryField(
    String title,
    TextEditingController controller,
    bool hideText,
  ) {
    return TextField(
      controller: controller,
      obscureText: hideText,
      decoration: InputDecoration(
        hintText: title,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // rounded corners
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Color.fromRGBO(139, 99, 218, 0.7)),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(
      errorMessage,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 14,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          loading = true;
        });
        dynamic result = await Auth().signInWithEmailAndPassword(
          _controllerEmail.text,
          _controllerPassword.text,
        );
        if (result == null) {
          setState(() {
            loading = false;
            errorMessage = 'Yeah, nah. That’s not a valid email or password.';
          });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(139, 99, 218, 0.7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // wrap content
        children: [
          Text(
            'Login',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(width: 8),
          Icon(Icons.login, color: Colors.white),
        ],
      ),
    );
  }

  Widget _loginText() {
    return Text(
      "Login",
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 32,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _myClip(double width, double height) {
    return ClipPath(
      clipper: BottomWaveClipper(),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(139, 99, 218, 0.7), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.all(0),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: _myClip(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height / 3,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: _loginText(),
                        ),
                        SizedBox(height: 20),
                        _entryField("Email", _controllerEmail, false),
                        SizedBox(height: 10),
                        _entryField("Password", _controllerPassword, true),
                        SizedBox(height: 20),
                        _errorMessage(),
                        SizedBox(height: 30),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: _submitButton(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
