import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/representation/screens/home_screen.dart';
import 'package:mobile_app_blockchain/representation/screens/information_screen.dart';

import 'package:mobile_app_blockchain/representation/screens/intro_screen.dart';
import 'package:mobile_app_blockchain/representation/screens/main_app_screen.dart';
import 'package:mobile_app_blockchain/representation/screens/product_screen.dart';
import 'package:mobile_app_blockchain/representation/screens/profile.screen.dart';
import 'package:mobile_app_blockchain/representation/screens/qrcode_screen.dart';

import 'package:mobile_app_blockchain/representation/screens/register_screen.dart';

import 'representation/screens/login_screen.dart';
import 'representation/screens/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  MainAppScreen.routeName: (context) => const MainAppScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProductScreen.routeName: (context) => const ProductScreen(),
  QRCodeScreen.routeName: (context) => const QRCodeScreen(),
  InformationScreen.routeName: (context) => const InformationScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
};
