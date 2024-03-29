import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/core/constants/dismenssion_constants.dart';
import 'package:mobile_app_blockchain/core/constants/textstyle_constants.dart';
import 'package:mobile_app_blockchain/features/home/screens/main_app_screen.dart';
import 'package:mobile_app_blockchain/features/auth/screens/register_screen.dart';
import 'package:mobile_app_blockchain/features/widgets/appBar_widget.dart';
import 'package:mobile_app_blockchain/features/widgets/button_widgets.dart';
import 'package:mobile_app_blockchain/features/widgets/textfiled_widget.dart';

import '../../../core/helpers/assets_helper.dart';
import '../../../core/helpers/image_helper.dart';
import '../../admin/screens/intro_screen.dart';
import '../../home/screens/home_screen.dart';
import '../../qrcode/screens/qrcode_screen.dart';
import '../services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = '/login_screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  final AuthService authService = AuthService();

  void LogInUser() {
    authService.SignInUser(
        context: context,
        email: _emailTextController.text,
        password: _passwordTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorPalette.primaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(IntroScreen.routeName);
            },
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              size: kDefaultIconSize,
              color: ColorPalette.text1Color,
            )),
      ),
      body: Container(
        constraints:
            BoxConstraints(maxHeight: size.height, maxWidth: size.width),
        decoration: BoxDecoration(
          color: ColorPalette.primaryColor,
        ),
        child: Column(children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kMediumPadding),
                      topRight: Radius.circular(kMediumPadding))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: kDefaultPadding),
                      Center(
                        child: Container(
                          width: 90,
                          height: 80,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child:
                                  ImageHelper.loadFromAsset(AssetsHelper.logo)),
                        ),
                      ),
                      SizedBox(height: kDefaultPadding),
                      Text(
                        'Đăng nhập',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: kDefaultPadding * 3),
                      reusableTextFiled("Nhập email", FontAwesomeIcons.user,
                          false, _emailTextController),
                      SizedBox(height: kDefaultPadding * 2),
                      reusableTextFiled("Nhập password", FontAwesomeIcons.lock,
                          true, _passwordTextController),
                      SizedBox(height: kDefaultPadding * 3),
                      ButtonWidget(title: "Đăng nhập", onTap: LogInUser),
                      SizedBox(height: kDefaultPadding * 3),
                      RichText(
                        text: TextSpan(
                            text: "Bạn là người dùng mới?",
                            style: TextStyle(
                                color: ColorPalette.text1Color, fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context)
                                          .pushNamed(RegisterScreen.routeName);
                                    },
                                  text: " Đăng ký",
                                  style: TextStyle(
                                      color: ColorPalette.blueColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600))
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
