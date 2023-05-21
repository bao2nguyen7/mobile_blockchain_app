import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/features/widgets/rounded_icon_btn.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({super.key});

  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RoundedIconBtn(
                icon: Icons.arrow_back_ios,
                press: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}
