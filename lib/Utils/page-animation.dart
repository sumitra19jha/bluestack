import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color kDarkGray = Color(0xFFA3A3A3);

class PageTransition {
  static Route<Map<String, dynamic>> show(Widget navigatedTo) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => navigatedTo,
      fullscreenDialog: true,
      transitionDuration: Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}
