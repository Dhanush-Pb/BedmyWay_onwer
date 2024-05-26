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

PageRouteBuilder transition3({
  required Widget child,
  required Curve curve,
  required AxisDirection axisDirection,
  bool fade = false,
}) {
  if (fade) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  } else {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin:
                Offset(axisDirection == AxisDirection.left ? 1.0 : -1.0, 0.0),
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
}

PageRouteBuilder transition2({
  required Widget child,
  required Curve curve,
  required AxisDirection axisDirection,
}) {
  final opacityTween = Tween(begin: 0.0, end: 1.0);

  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation.drive(opacityTween),
        child: child,
      );
    },
  );
}
