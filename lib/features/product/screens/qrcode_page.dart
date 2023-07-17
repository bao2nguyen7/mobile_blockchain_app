// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/constants/color_constants.dart';

class QRCodePage extends StatefulWidget {
  String id;
  QRCodePage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QrCode "),
        backgroundColor: ColorPalette.primaryColor,
      ),
      body: Center(
          child: QrImageView(
        data: widget.id,
        version: QrVersions.auto,
        size: 400.0,
      )),
    );
  }
}
