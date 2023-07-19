import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/constants/color_constants.dart';

RichText reuseableRichText(String text) {
  return RichText(
      text: TextSpan(
          text: text,
          style: TextStyle(color: ColorPalette.text1Color, fontSize: 16),
          children: <TextSpan>[
        TextSpan(
            text: " *",
            style: TextStyle(
                color: Colors.red, fontSize: 16, fontWeight: FontWeight.w800))
      ]));
}

RichText reuseableRichTextNo(String text) {
  return RichText(
      text: TextSpan(
          text: text,
          style: TextStyle(color: ColorPalette.text1Color, fontSize: 16),
          children: <TextSpan>[
        TextSpan(
            text: " *",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800))
      ]));
}
