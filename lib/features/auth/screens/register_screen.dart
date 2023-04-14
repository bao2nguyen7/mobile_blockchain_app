import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/dismenssion_constants.dart';
import '../../../core/helpers/assets_helper.dart';
import '../../../core/helpers/image_helper.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/textfiled_widget.dart';
import '../services/auth_services.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String routeName = '/register_screen';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final AuthService authService = AuthService();
  void signupUser() {
    authService.SignUpUser(
        context: context,
        email: _emailTextController.text,
        password: _passwordTextController.text,
        name: _nameTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorPalette.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorPalette.primaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              size: kDefaultIconSize,
              color: ColorPalette.text1Color,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: kMediumPadding),
                  child: Column(
                    children: [
                      SizedBox(height: kDefaultPadding),
                      Center(
                        child: Container(
                          width: 90,
                          height: 80,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child:
                                  ImageHelper.loadFromAsset(AssetsHelper.logo)),
                        ),
                      ),
                      SizedBox(height: kDefaultPadding),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: kDefaultPadding * 3),
                      reusableTextFiled("Name", FontAwesomeIcons.user, false,
                          _nameTextController),
                      SizedBox(height: kDefaultPadding * 2),
                      reusableTextFiled("Email", FontAwesomeIcons.envelope,
                          false, _emailTextController),
                      SizedBox(height: kDefaultPadding * 2),
                      reusableTextFiled("Password", FontAwesomeIcons.lock, true,
                          _passwordTextController),
                      SizedBox(height: kDefaultPadding * 3),
                      ButtonWidget(title: "Sign Up", onTap: signupUser
                          // () {
                          //   Navigator.of(context)
                          //       .pushNamed(LoginScreen.routeName);
                          // },
                          ),
                      SizedBox(height: kDefaultPadding * 3),
                      RichText(
                        text: TextSpan(
                            text: "Already a User?",
                            style: TextStyle(
                                color: ColorPalette.text1Color, fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context)
                                          .pushNamed(LoginScreen.routeName);
                                    },
                                  text: " Login now",
                                  style: TextStyle(
                                      color: ColorPalette.blueColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800))
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
