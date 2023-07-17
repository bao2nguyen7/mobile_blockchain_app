import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/helpers/assets_helper.dart';
import 'package:mobile_app_blockchain/core/helpers/image_helper.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_providers.dart';
import '../../auth/services/auth_services.dart';
import '../screens/profile_detail_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  void SignOutUser(BuildContext context) {
    AuthService().SignOutUser(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          Text(user.name, style: Theme.of(context).textTheme.headline4),
          Text(user.email, style: Theme.of(context).textTheme.bodyText2),
          ProfileMenu(
            text: "Tài khoản của tôi",
            icon: AssetsHelper.bell,
            press: () => {},
          ),
          ProfileMenu(
            text: "Thông báo",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Cài đặt",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Trung tâm giúp đỡ",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Đăng xuất",
            icon: "assets/icons/Log out.svg",
            press: () => SignOutUser(context),
          ),
        ],
      ),
    );
  }
}
