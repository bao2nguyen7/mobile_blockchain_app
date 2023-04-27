import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/features/home/screens/home_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/infor_product_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/add_product_screen.dart';
import 'package:mobile_app_blockchain/features/qrcode/screens/qrcode_screen.dart';
import 'package:mobile_app_blockchain/features/admin/screens/intro_screen.dart';
import 'package:mobile_app_blockchain/features/home/screens/main_app_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/product_screen.dart';
import 'package:mobile_app_blockchain/features/auth/screens/profile.screen.dart';
import 'package:mobile_app_blockchain/features/newfeed/screens/newfeed.dart';
import 'package:mobile_app_blockchain/features/auth/screens/register_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/updateInfor_screen.dart';
import 'package:mobile_app_blockchain/models/user.dart';

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
  AddProductScreen.routeName: (context) => const AddProductScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  InforProductScreen.routeName: (context) => const InforProductScreen(),
  NewFeedScreen.routeName: (context) => const NewFeedScreen(),
  UpdateInformationScreen.routeName: (context) =>
      const UpdateInformationScreen(),
};

// Route<dynamic> generateRoute(RouteSettings routeSettings) {
//   switch (routeSettings.name) {
//     case SplashScreen.routeName:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => const SplashScreen(),
//       );

//     case IntroScreen.routeName:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => const IntroScreen(),
//       );
//     case LoginScreen.routeName:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => const LoginScreen(),
//       );
//     case RegisterScreen.routeName:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => const RegisterScreen(),
//       );

//     case MainAppScreen.routeName:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => MainAppScreen(),
//       );
//     case HomeScreen.routeName:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => HomeScreen(),
//       );
//     case ProductScreen.routeName:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => ProductScreen(),
//       );
//     case QRCodeScreen.routeName:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => QRCodeScreen(),
//       );
//     case ProfileScreen.routeName:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => ProfileScreen(),
//       );
//     case InforProductScreen.routeName:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => InforProductScreen(),
//       );
//     case NewFeedScreen.routeName:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => NewFeedScreen(),
//       );
//     case UpdateInformationScreen.routeName:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => UpdateInformationScreen(),
//       );
//     case AddProductScreen.routeName:
//       var user = routeSettings.arguments as User;
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => AddProductScreen(user: user),
//       );
//     default:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => const Scaffold(
//           body: Center(
//             child: Text('Screen does not exist!'),
//           ),
//         ),
//       );
