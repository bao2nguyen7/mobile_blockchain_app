import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/features/home/screens/home_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/infor_product_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/information_screen.dart';
import 'package:mobile_app_blockchain/features/qrcode/screens/qrcode_screen.dart';
import 'package:mobile_app_blockchain/features/admin/screens/intro_screen.dart';
import 'package:mobile_app_blockchain/features/home/screens/main_app_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/product_screen.dart';
import 'package:mobile_app_blockchain/features/auth/screens/profile.screen.dart';
import 'package:mobile_app_blockchain/features/newfeed/screens/newfeed.dart';
import 'package:mobile_app_blockchain/features/auth/screens/register_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/updateInfor_screen.dart';

import 'features/auth/screens/login_screen.dart';
import 'features/admin/screens/splash_screen.dart';

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
  InforProductScreen.routeName: (context) => const InforProductScreen(),
  NewFeedScreen.routeName: (context) => const NewFeedScreen(),
  UpdateInformationScreen.routeName: (context) =>
      const UpdateInformationScreen(),
};
