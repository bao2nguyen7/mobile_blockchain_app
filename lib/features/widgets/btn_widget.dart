// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/dismenssion_constants.dart';

class BtnWidget extends StatelessWidget {
  const BtnWidget({
    Key? key,
    required this.title,
    required this.image,
    this.onTap,
  }) : super(key: key);
  final String title;
  final Widget image;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: kMaxbtnSize,
            height: kMaxbtnSize,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(kDefaultPadding)),
                color: ColorPalette.primaryColor),
            child: Column(
              children: [
                SizedBox(
                  height: kDefaultPadding * 2,
                ),
                image,
                SizedBox(height: kMinPadding),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: kTextMediumSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
