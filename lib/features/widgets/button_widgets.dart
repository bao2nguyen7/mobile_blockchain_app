import 'package:flutter/material.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/dismenssion_constants.dart';
import '../../core/constants/textstyle_constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.title, this.onTap});
  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kMediumPadding),
            color: ColorPalette.primaryColor),
        child: Text(title, style: TextStyles.defaultStyle.bold.whiteTextColor),
      ),
    );
  }
}
