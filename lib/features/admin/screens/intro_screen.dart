import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/constants/dismenssion_constants.dart';
import 'package:mobile_app_blockchain/core/helpers/assets_helper.dart';
import 'package:mobile_app_blockchain/core/helpers/image_helper.dart';
import 'package:mobile_app_blockchain/features/auth/screens/login_screen.dart';
import 'package:mobile_app_blockchain/features/qrcode/screens/qrcode_screen.dart';
import 'package:mobile_app_blockchain/features/widgets/button_widgets.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});
  static String routeName = '/intro_screen';
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
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
                              borderRadius: BorderRadius.circular(30.0),
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
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(QRCodeScreen.routeName);
                        },
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
