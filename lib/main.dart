import 'package:abiw_tes1/splashscreenku.dart';
import 'package:abiw_tes1/walkt.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Clean Code',
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: SplashScreen(),
            nextScreen: Walkt(),
            splashTransition: SplashTransition
                .scaleTransition, // Transisi animasi dari splash screen (berupa scaling)
            pageTransitionType: PageTransitionType.leftToRight,
            backgroundColor: Color.fromARGB(255, 255, 255, 255)));
  }
}
