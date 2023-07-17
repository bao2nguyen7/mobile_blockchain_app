import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';

void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
      content: Text(
        text,
      ),
      // behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromARGB(255, 200, 222, 183),
      duration: const Duration(seconds: 5));
  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}
