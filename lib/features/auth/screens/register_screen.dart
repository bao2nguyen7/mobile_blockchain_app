import 'package:dropdown_button2/dropdown_button2.dart';
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
  static const String routeName = '/register_screen';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  _RegisterScreenState() {
    valueChoose = listitems[0];
  }
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final AuthService authService = AuthService();
  void signupUser() {
    authService.SignUpUser(
      context: context,
      email: _emailTextController.text,
      password: _passwordTextController.text,
      name: _nameTextController.text,
      userType: valueChoose,
    );
  }

  String valueChoose = "";
  List listitems = ["User", "Farmer"];
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
              Navigator.pop(context);
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
                        'Đăng ký',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: kDefaultPadding * 3),
                      reusableTextFiled("Tên", FontAwesomeIcons.user, false,
                          _nameTextController),
                      SizedBox(height: kDefaultPadding * 2),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          focusColor: ColorPalette.subTitleColor,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              gapPadding: 50),
                        ),
                        buttonStyleData: ButtonStyleData(
                          height: 60,
                          width: 160,
                          padding: const EdgeInsets.only(left: 11, right: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.black, width: 0.5),
                            color: ColorPalette.subTitleColor.withOpacity(0.3),
                          ),
                          elevation: 0,
                        ),
                        isExpanded: true,
                        hint: Row(
                          children: [
                            Icon(Icons.brightness_5_outlined,
                                color: ColorPalette.subTitleColor),
                            SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Chọn vai trò',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        items: listitems
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Row(
                                    children: [
                                      Icon(Icons.brightness_5_outlined,
                                          color: ColorPalette.subTitleColor),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Xin hãy chọn vai trò';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            valueChoose = value.toString();
                            print(valueChoose);
                          });
                        },
                        onSaved: (value) {
                          valueChoose = value.toString();
                          print(valueChoose);
                        },
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(height: kDefaultPadding * 2),
                      reusableTextFiled("Email", FontAwesomeIcons.envelope,
                          false, _emailTextController),
                      SizedBox(height: kDefaultPadding * 2),
                      reusableTextFiled("Mật khẩu", FontAwesomeIcons.lock, true,
                          _passwordTextController),
                      SizedBox(height: kDefaultPadding * 3),
                      ButtonWidget(title: "Đăng ký", onTap: signupUser),
                      SizedBox(height: kDefaultPadding * 3),
                      RichText(
                        text: TextSpan(
                            text: "Bạn sẵn sàng là người dùng?",
                            style: TextStyle(
                                color: ColorPalette.text1Color, fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context)
                                          .pushNamed(LoginScreen.routeName);
                                    },
                                  text: " Đăng nhập",
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
          ),
        ]),
      ),
    );
  }
}
