import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/features/home/screens/home_screen.dart';
import 'package:mobile_app_blockchain/features/admin/screens/splash_screen.dart';
import 'package:mobile_app_blockchain/providers/user_providers.dart';
import 'package:mobile_app_blockchain/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child: const MyApp(),
  ));
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
