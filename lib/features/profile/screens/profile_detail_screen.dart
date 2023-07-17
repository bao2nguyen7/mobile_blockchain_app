import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_blockchain/features/profile/screens/profile_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/dismenssion_constants.dart';
import '../../../providers/user_providers.dart';
import '../../home/screens/main_app_screen.dart';
import '../../user/home_user/screens/main_app_screen.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/richText_widget.dart';
import '../../widgets/textfieldName_widget.dart';
import '../../auth/services/auth_services.dart';
import '../../auth/screens/login_screen.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});
  static const String routeName = '/profile_detail_screen';
  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _roleTextController = TextEditingController();
  TextEditingController _codeTextController = TextEditingController();
  TextEditingController timeinput = TextEditingController();

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
          "Tài khoản",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
        ),
        elevation: 0,
        backgroundColor: ColorPalette.primaryColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                user.userType != "User"
                    ? Navigator.of(context).pushNamed(MainAppScreen.routeName)
                    : Navigator.of(context)
                        .pushNamed(MainAppUserScreen.routeName);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
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
                                      'Tên',
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
                                      'Vai trò',
                                      style: TextStyle(
                                          color: ColorPalette.text1Color,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                reusableTextFiledName(
                                    user.userType, _roleTextController, false),
                                SizedBox(height: kDefaultPadding * 2),
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
