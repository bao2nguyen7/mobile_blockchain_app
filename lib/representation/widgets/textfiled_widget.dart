import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';

TextField reusableTextFiled(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: ColorPalette.subTitleColor,
    style: TextStyle(color: Color.fromARGB(255, 39, 22, 22).withOpacity(0.9)),
    decoration: InputDecoration(
        prefixIcon: Icon(icon, color: ColorPalette.subTitleColor),
        labelText: text,
        labelStyle:
            TextStyle(color: ColorPalette.subTitleColor.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: ColorPalette.subTitleColor.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
                width: 0.5, style: BorderStyle.solid, color: Colors.black))),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}
