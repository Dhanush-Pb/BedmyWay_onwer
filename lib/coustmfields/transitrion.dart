import 'package:flutter/material.dart';

PageRouteBuilder buildPageTransition({
  required Widget child,
  required Curve curve,
  required AxisDirection axisDirection,
}) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => child,
    transitionsBuilder: (_, animation, __, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(axisDirection == AxisDirection.left ? 1.0 : -1.0, 0.0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: curve,
          ),
        ),
        child: child,
      );
    },
  );
}
