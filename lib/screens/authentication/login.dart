import 'package:flutter/material.dart';
import 'package:winetopia_app/services/firebase_auth.dart';
//import 'package:winetopia_app/shares/clip_path.dart';
import 'package:winetopia_app/shares/setting.dart';
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

  // Widget _myClip(double width, double height) {
  //   return ClipPath(
  //     clipper: BottomWaveClipper(),
  //     child: Container(
  //       height: height,
  //       width: width,
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //           colors: [Setting().otherComponentColor, Colors.white],
  //           begin: Alignment.topCenter,
  //           end: Alignment.bottomCenter,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _loginText() {
    return Text(
      "Login",
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 32,
        color: Setting().textColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _contactUsDialog() {
    return AlertDialog(
      title: Text("Contact Us", style: TextStyle(color: Setting().textColor)),
      backgroundColor: Setting().bodyContainerBackgroundColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Email: tech@lemongrassproductions.co.nz"),
          SizedBox(height: 8),
          Text(
            "During event time, please see one of our staff member for assistance!",
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text("Close"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _contactUs() {
    return Row(
      children: [
        Text(
          "Need help? ",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16, color: Setting().textColor),
        ),
        GestureDetector(
          onTap:
              () => showDialog(
                context: context,
                builder: (_) => _contactUsDialog(),
              ),
          child: Text(
            "Contact us",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              color: Setting().textColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

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
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Setting().borderLineColor),
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
        dynamic result = await AuthService().signInWithEmailAndPassword(
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
        backgroundColor: Setting().buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // wrap content
        children: [
          Text(
            'Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Setting().textColorLight,
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.login, color: Setting().otherComponentColorLight),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
          backgroundColor: Setting().bodyContainerBackgroundColor,
          body: Container(
            padding: EdgeInsets.all(0),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child:
                    // Stack(
                    //   children: [
                    // _myClip(
                    //   MediaQuery.of(context).size.width,
                    //   MediaQuery.of(context).size.height / 3,
                    // ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'assets/images/Winetopia_Logo2024.png',
                        height: 200,
                        width: 200,
                      ),
                    ),
                    // ],
                  ),
                  // ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: _loginText(),
                        ),

                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topLeft,
                          child: _contactUs(),
                        ),
                        SizedBox(height: 30),
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
