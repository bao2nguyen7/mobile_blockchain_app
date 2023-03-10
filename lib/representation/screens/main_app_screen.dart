import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app_blockchain/representation/screens/home_screen.dart';
import 'package:mobile_app_blockchain/representation/screens/product_screen.dart';
import 'package:mobile_app_blockchain/representation/screens/profile.screen.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/dismenssion_constants.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});
  static String routeName = '/main_app_screen';
  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(index: _currentIndex, children: [
          HomeScreen(),
          ProductScreen(),
          Container(color: Colors.white),
          ProfileScreen(),
        ]),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: ColorPalette.primaryColor,
          unselectedItemColor: ColorPalette.primaryColor.withOpacity(0.2),
          margin: EdgeInsets.symmetric(
              vertical: kMediumPadding, horizontal: kDefaultPadding),
          items: [
            SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.house, size: kDefaultIconSize),
                title: Text('Home')),
            SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.layerGroup, size: kDefaultIconSize),
                title: Text('Product')),
            SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.briefcase, size: kDefaultIconSize),
                title: Text('Booking ')),
            SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.solidUser, size: kDefaultIconSize),
                title: Text('Profile')),
          ],
        ));
  }
}
