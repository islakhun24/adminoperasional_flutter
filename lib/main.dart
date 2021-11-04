import 'package:admin_operasional/pages/splashscreen_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Splash Screen',
    theme: ThemeData(fontFamily: 'Roboto'),
    home: const SplashscreenPage(),
  ));
}
