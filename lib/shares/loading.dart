import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:winetopia_app/shares/setting.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Setting().bodyContainerBackgroundColor,
      child: Center(
        child: SpinKitChasingDots(
          color: Setting().otherComponentColor,
          size: 50.0,
        ),
      ),
    );
  }
}
