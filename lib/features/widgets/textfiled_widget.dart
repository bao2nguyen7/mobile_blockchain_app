import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';

TextFormField reusableTextFiled(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextFormField(
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
    autovalidateMode: AutovalidateMode.onUserInteraction,
    // The validator receives the text that the user has entered.
    validator: (text) {
      if (text == null || text.isEmpty) {
        return 'Can\'t be empty';
      }
      if (text.length < 3) {
        return 'Too short';
      }
      return null;
    },
  );
}
