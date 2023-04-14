import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/helpers/assets_helper.dart';
import 'package:mobile_app_blockchain/core/helpers/image_helper.dart';
import 'package:mobile_app_blockchain/features/product/screens/updateInfor_screen.dart';
import 'package:mobile_app_blockchain/features/widgets/button_widgets.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/dismenssion_constants.dart';
import '../../../core/constants/textstyle_constants.dart';

class InforProductScreen extends StatefulWidget {
  const InforProductScreen({super.key});
  static String routeName = '/infor_product_screen';
  @override
  State<InforProductScreen> createState() => _InforProductScreenState();
}

class _InforProductScreenState extends State<InforProductScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          width: size.width,
          child: ImageHelper.loadFromAsset(AssetsHelper.logo),
        ),
        buttonArrow(context),
        scroll(),
      ],
    ));
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
            clipBehavior: Clip.hardEdge,
            height: 130,
            width: 60,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 55,
                width: 55,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(25)),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            )),
      ),
    );
  }

  scroll() {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 1.5,
      minChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        );
      },
    );
  }
}
