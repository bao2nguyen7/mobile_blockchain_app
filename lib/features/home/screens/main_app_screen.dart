import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app_blockchain/features/home/screens/home_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/add_product_screen.dart';
import 'package:mobile_app_blockchain/features/newfeed/screens/newfeed.dart';
import 'package:mobile_app_blockchain/features/product/screens/product_screen.dart';
import 'package:mobile_app_blockchain/features/profile/profile_screen.dart';
import 'package:mobile_app_blockchain/features/qrcode/screens/qrcode_screen.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/dismenssion_constants.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../qrcode/screens/qrcode_result.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});
  static const String routeName = '/main_app_screen';
  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;

  List<Widget> pages = const [
    HomeScreen(),
    ProductScreen(),
    NewFeedScreen(),
    ProfileScreen()
  ];

  List<IconData> icons = const [
    Icons.home,
    Icons.layers,
    Icons.newspaper,
    Icons.person
  ];

  List<String> titleList = ['Home', 'Product', 'New Feeds', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(QRCodeResultScreen.routeName);
          },
          backgroundColor: ColorPalette.primaryColor,
          child: const Icon(Icons.qr_code_2),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: Colors.white,
        body: IndexedStack(index: _currentIndex, children: pages),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          activeIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          splashColor: ColorPalette.primaryColor,
          activeColor: ColorPalette.primaryColor,
          inactiveColor: Colors.black.withOpacity(.5),
          icons: icons,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
        ));
  }
}
