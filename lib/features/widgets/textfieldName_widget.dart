import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';

TextFormField reusableTextFiledName(
    String text, TextEditingController controller, bool maxLiness) {
  return TextFormField(
    controller: controller,
    cursorColor: ColorPalette.subTitleColor,
    style: TextStyle(color: Color.fromARGB(255, 39, 22, 22).withOpacity(0.9)),
    decoration: InputDecoration(
        labelText: text,
        labelStyle:
            TextStyle(color: ColorPalette.subTitleColor.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: ColorPalette.subTitleColor.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                width: 0.1, style: BorderStyle.solid, color: Colors.black))),
    keyboardType: TextInputType.multiline,
    maxLines: maxLiness ? 8 : 1,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    // The validator receives the text that the user has entered.
    validator: (text) {
      if (text == null || text.isEmpty) {
        return 'Can\'t be empty';
      }
      if (text.length < 2) {
        return 'Too short';
      }
      return null;
    },
  );
}
