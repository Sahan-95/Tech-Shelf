
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

// Custom route for getting animation from transition screen
Route createRoute(Widget childScreen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => childScreen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeThroughTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      );
    },
    transitionDuration: const Duration(seconds: 1),
  );
}