import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/utils/constans.dart';

import '../../../models/process.dart';
import '../../../models/product.dart';
import '../../../models/tracking.dart';
import '../../newfeed/services/process_services.dart';
import '../screens/tracking_detail.dart';

Widget customListTile(Tracking tracking, Product product, Process? process,
    BuildContext context) {
  final ProcessServices processServices = ProcessServices();
  _seeDetail() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TrackingDetailScreen(
                  tracking: tracking,
                )));
  }

  String? stagePlantCare = process?.stagePlantCare?.name ?? '';
  String? stageBloom = process?.stageBloom?.name ?? '';
  String? stageHarvest = process?.stageHarvest?.name ?? '';
  String? stageSell = process?.stageSell?.name ?? '';
  String? stagePlantSeed = process?.stagePlantSeeds?.name ?? '';
  String? stageCover = process?.stageCover?.name ?? '';

  List<String?> nameStage() {
    return [
      stagePlantSeed,
      stagePlantCare,
      stageBloom,
      stageCover,
      stageHarvest,
      stageSell
    ];
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 3, right: 5),
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: tracking.name == nameStage()[1]
                    ? ColorPalette.primaryColor
                    : tracking.name == nameStage()[2]
                        ? Colors.amberAccent
                        : tracking.name == nameStage()[2]
                            ? Color.fromARGB(255, 71, 196, 205)
                            : tracking.name == nameStage()[3]
                                ? Color.fromARGB(255, 40, 17, 213)
                                : tracking.name == nameStage()[4]
                                    ? Color.fromARGB(255, 150, 64, 255)
                                    : Color.fromARGB(255, 255, 64, 102),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black26)),
          ),
          Text(tracking.name as String,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ],
      ),
      Container(
        margin: const EdgeInsets.only(left: 17),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        decoration: const BoxDecoration(
            border: Border(
                left: BorderSide(
          color: Color.fromARGB(255, 65, 105, 63),
        ))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Thời gian được tạo:',
                style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(
              height: 5,
            ),
            Text(tracking.time as String),
            SizedBox(
              height: 10,
            ),
            Text('Mô tả:', style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(
              height: 5,
            ),
            Text(tracking.description as String),
            SizedBox(
              height: 40,
            ),
            RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = _seeDetail,
                    text: "Xem thêm",
                    style: TextStyle(
                        color: ColorPalette.primaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w800)))
          ],
        ),
      ),
    ],
  );
}
