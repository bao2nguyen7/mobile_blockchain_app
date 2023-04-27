import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user =
      User(id: '', name: '', email: '', password: '', token: '', products: []);

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
