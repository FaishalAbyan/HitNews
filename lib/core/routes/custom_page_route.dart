import 'package:flutter/material.dart';

// CustomPageRoute untuk transisi halaman fade
class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction; // Arah transisi (opsional)

  CustomPageRoute({
    required this.child,
    this.direction = AxisDirection.right, // Default dari kanan
    RouteSettings? settings,
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) => child,
         settings: settings,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           // Animasi Fade
           // return FadeTransition(
           //   opacity: animation,
           //   child: child,
           // );

           // Animasi Slide dari arah tertentu
           return SlideTransition(
             position: Tween<Offset>(
               begin: getBeginOffset(direction),
               end: Offset.zero,
             ).animate(animation),
             child: child,
           );
         },
         transitionDuration: const Duration(
           milliseconds: 300,
         ), // Durasi transisi
       );

  // Helper untuk mendapatkan offset awal berdasarkan arah
  static Offset getBeginOffset(AxisDirection direction) {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.left:
        return const Offset(1, 0);
      case AxisDirection.right:
        return const Offset(-1, 0);
    }
  }
}
