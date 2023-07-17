import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/features/home/screens/home_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/infor_product_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/add_product_screen.dart';
import 'package:mobile_app_blockchain/features/qrcode/screens/qrcode_screen.dart';
import 'package:mobile_app_blockchain/features/admin/screens/intro_screen.dart';
import 'package:mobile_app_blockchain/features/home/screens/main_app_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/product_screen.dart';

import 'package:mobile_app_blockchain/features/newfeed/screens/newfeed.dart';
import 'package:mobile_app_blockchain/features/auth/screens/register_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/add_tracking_screen.dart';
import 'package:mobile_app_blockchain/models/user.dart';

import 'features/auth/screens/login_screen.dart';
import 'features/admin/screens/splash_screen.dart';
import 'features/product/screens/journal_sceen.dart';
import 'features/product/screens/product_user_screen.dart';
import 'features/user/home_user/screens/home_screen.dart';
import 'features/user/home_user/screens/main_app_screen.dart';
import 'features/newfeed/screens/newfeed_detail.dart';
import 'features/product/screens/detail_product_screen.dart';
import 'features/product/screens/tracking_detail.dart';
import 'features/profile/screens/profile_detail_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'features/qrcode/screens/qrcode_result.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  MainAppScreen.routeName: (context) => const MainAppScreen(),
  MainAppUserScreen.routeName: (context) => const MainAppUserScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  HomeUserScreen.routeName: (context) => const HomeUserScreen(),
  ProductScreen.routeName: (context) => const ProductScreen(),
  ProductUserScreen.routeName: (context) => const ProductUserScreen(),
  JournalScreen.routeName: (context) => const JournalScreen(),
  QRCodeScreen.routeName: (context) => const QRCodeScreen(),
  AddProductScreen.routeName: (context) => const AddProductScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  ProfileDetailScreen.routeName: (context) => const ProfileDetailScreen(),
  InforProductScreen.routeName: (context) => const InforProductScreen(),
  NewFeedScreen.routeName: (context) => const NewFeedScreen(),
};
