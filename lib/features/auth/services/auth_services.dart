import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/models/user.dart';
import 'package:mobile_app_blockchain/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/user_providers.dart';
import '../../../utils/constans.dart';
import '../../home/screens/main_app_screen.dart';
import '../../user/home_user/screens/home_screen.dart';
import '../../user/home_user/screens/main_app_screen.dart';
import '../../newfeed/screens/newfeed.dart';
import '../screens/login_screen.dart';

class AuthService {
  //SignUp Service
  void SignUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String userType,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          password: password,
          email: email,
          userType: userType,
          token: '',
          products: []);
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //SignIn User
  void SignInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userProvider.setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          if (jsonDecode(res.body)['userType'] == "Farmer") {
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const MainAppScreen(),
              ),
              (route) => false,
            );
          } else if (jsonDecode(res.body)['userType'] == "User") {
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const MainAppUserScreen(),
              ),
              (route) => false,
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //Sign Out User
  void SignOutUser(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');
    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }

  //getUserData
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('${Constants.uri}/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('${Constants.uri}/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
