import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/dismenssion_constants.dart';
import '../../../providers/user_providers.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/richText_widget.dart';
import '../../widgets/textfieldName_widget.dart';
import '../services/auth_services.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String routeName = '/profile_screen';
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _roleTextController = TextEditingController();
  TextEditingController _codeTextController = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  void SignOutUser(BuildContext context) {
    AuthService().SignOutUser(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        titleSpacing: 20,
        title: Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
        ),
        elevation: 0,
        backgroundColor: ColorPalette.primaryColor,
      ),
      backgroundColor: ColorPalette.primaryColor,
      body: Container(
          constraints: BoxConstraints(
            maxHeight: size.height,
            maxWidth: size.width,
          ),
          decoration: BoxDecoration(
            color: ColorPalette.primaryColor,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: ColorPalette.primaryColor,
                ),
              ),
              Expanded(
                flex: 25,
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(kMediumPadding),
                            topRight: Radius.circular(kMediumPadding))),
                    child: Container(
                      child: Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: kDefaultPadding),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                          color: ColorPalette.text1Color,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                reusableTextFiledName(
                                    user.name, _nameTextController, false),
                                SizedBox(height: kDefaultPadding * 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Role',
                                      style: TextStyle(
                                          color: ColorPalette.text1Color,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                reusableTextFiledName(
                                    "User", _roleTextController, false),
                                SizedBox(height: kDefaultPadding * 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Address',
                                      style: TextStyle(
                                          color: ColorPalette.text1Color,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                reusableTextFiledName(
                                    "Code", _codeTextController, false),
                                SizedBox(height: kDefaultPadding * 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Blockchain Address',
                                      style: TextStyle(
                                          color: ColorPalette.text1Color,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                reusableTextFiledName("Blockchain Address",
                                    _codeTextController, false),
                                SizedBox(height: kDefaultPadding * 4),
                                RichText(
                                  text: TextSpan(
                                      text: "",
                                      style: TextStyle(
                                          color: ColorPalette.text1Color,
                                          fontSize: 16),
                                      children: <TextSpan>[
                                        TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap =
                                                  () => SignOutUser(context),
                                            text: "Log Out",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 187, 32, 21),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))
                                      ]),
                                )
                              ],
                            ),
                          )),
                    )),
              )
            ],
          )),
    );
  }
}
