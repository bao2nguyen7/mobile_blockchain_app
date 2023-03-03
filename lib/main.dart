import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/representation/screens/home_screen.dart';
import 'package:mobile_app_blockchain/representation/screens/splash_screen.dart';
import 'package:mobile_app_blockchain/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BlockchainApp',
      routes: routes,
      theme: ThemeData(
        primaryColor: ColorPalette.primaryColor,
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: ColorPalette.primaryColor,
      ),
      home: const SplashScreen(),
    );
  }
}
