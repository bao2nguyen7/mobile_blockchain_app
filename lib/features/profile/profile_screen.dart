import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/features/profile/components/body.dart';

import '../../core/constants/color_constants.dart';
import '../home/screens/main_app_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String routeName = '/profile_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        titleSpacing: 20,
        title: Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pushNamed(MainAppScreen.routeName);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: Body(),
    );
  }
}
