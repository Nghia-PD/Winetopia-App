import 'package:flutter/material.dart';

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Start at top-left
    path.lineTo(0, size.height);
    path.lineTo(size.width / 3 * 2, size.height);
    path.quadraticBezierTo(
      size.width / 3 * 2 + 100,
      size.height / 2,
      size.width / 3 * 2,
      0,
    );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
