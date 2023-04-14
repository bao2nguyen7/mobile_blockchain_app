import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/dismenssion_constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget(
      {super.key,
      required this.title,
      required this.child,
      this.titleString,
      this.implementLeading = false,
      this.implementTraling = false});
  final Widget? title;
  final String? titleString;
  final Widget child;
  final bool implementLeading;
  final bool implementTraling;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: 186,
          child: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 190,
            title: title ??
                Row(children: [
                  if (implementLeading)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(kDefaultPadding)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(kItemPadding),
                      child: Icon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.black,
                        size: kDefaultIconSize,
                      ),
                    ),
                  Expanded(
                      child: Center(
                          child: Column(
                    children: [
                      Text(titleString ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18))
                    ],
                  ))),
                  if (implementTraling)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(kDefaultPadding)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(kItemPadding),
                      child: Icon(
                        FontAwesomeIcons.bars,
                        color: Colors.black,
                        size: kDefaultIconSize,
                      ),
                    ),
                ]),
            backgroundColor: ColorPalette.backgroundScaffoldColor,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: ColorPalette.primaryColor,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(35)),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 156),
          padding: EdgeInsets.symmetric(horizontal: kMediumPadding),
          child: child,
        )
      ],
    ));
  }
}
