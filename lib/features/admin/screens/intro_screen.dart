import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobile_app_blockchain/core/constants/dismenssion_constants.dart';
import 'package:mobile_app_blockchain/core/helpers/assets_helper.dart';
import 'package:mobile_app_blockchain/core/helpers/image_helper.dart';
import 'package:mobile_app_blockchain/features/auth/screens/login_screen.dart';
import 'package:mobile_app_blockchain/features/qrcode/screens/qrcode_screen.dart';
import 'package:mobile_app_blockchain/features/widgets/button_widgets.dart';

import '../../qrcode/screens/qrcode_result.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});
  static const String routeName = '/intro_screen';
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  String? scanResult = "";
  Future scanBarCode() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', "Cancel", true, ScanMode.QR);
      print(scanResult);
      if (scanResult != -1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QRCodeResultScreen(
                      id: scanResult,
                    )));
      }
    } on PlatformException {
      scanResult = "Fail";
    }
    if (!mounted) return;
    setState(() => this.scanResult = scanResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned.fill(
                child: Opacity(
                    opacity: 0.2,
                    child: ImageHelper.loadFromAsset(AssetsHelper.background,
                        fit: BoxFit.cover))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(kMaxIconSize),
                        child: Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child:
                                  ImageHelper.loadFromAsset(AssetsHelper.logo)),
                        ),
                      ),
                    ),
                    SizedBox(height: kMediumPadding * 6),
                    ButtonWidget(
                        title: 'Start',
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(LoginScreen.routeName);
                        }),
                    SizedBox(height: kMediumPadding),
                    Opacity(
                      opacity: 0.8,
                      child: ButtonWidget(
                        title: 'QR Code ',
                        onTap: scanBarCode,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
