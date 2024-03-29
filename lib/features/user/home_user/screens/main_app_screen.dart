import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app_blockchain/features/home/screens/home_screen.dart';
import 'package:mobile_app_blockchain/features/user/home_user/screens/home_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/add_product_screen.dart';
import 'package:mobile_app_blockchain/features/newfeed/screens/newfeed.dart';
import 'package:mobile_app_blockchain/features/product/screens/product_screen.dart';
import 'package:mobile_app_blockchain/features/profile/screens/profile_screen.dart';
import 'package:mobile_app_blockchain/features/qrcode/screens/qrcode_screen.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/dismenssion_constants.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../product/screens/product_user_screen.dart';
import '../../../qrcode/screens/qrcode_result.dart';

class MainAppUserScreen extends StatefulWidget {
  const MainAppUserScreen({super.key});
  static const String routeName = '/main_app_user_screen';
  @override
  State<MainAppUserScreen> createState() => _MainAppUserScreenState();
}

class _MainAppUserScreenState extends State<MainAppUserScreen> {
  int _currentIndex = 0;

  List<Widget> pages = const [
    HomeUserScreen(),
    ProductUserScreen(),
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

  String? scanResult = "";
  Future scanBarCode() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', "Cancel", true, ScanMode.QR);
      print(scanResult);
      if (scanResult != "-1") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QRCodeResultScreen(
                      id: scanResult,
                    )));
      } else {}
    } on PlatformException {
      scanResult = "Fail";
    }
    if (!mounted) return;
    setState(() => this.scanResult = scanResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: scanBarCode,
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
