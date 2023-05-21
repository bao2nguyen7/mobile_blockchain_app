import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/features/qrcode/screens/qrcode_result.dart';

import '../../home/screens/main_app_screen.dart';
import '../../product/screens/detail_product_screen.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});
  static const String routeName = '/qrcode_screen';
  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  String? scanResult = "";
  String? scan;
  Future scanBarCode() async {
    try {
      scan = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', "Cancel", true, ScanMode.QR);
      setState(() {
        scanResult = scan;
      });
      Navigator.of(context).pushNamed(QRCodeResultScreen.routeName);
    } on PlatformException {
      scanResult = "Fail";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: Text('QR Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: scanBarCode,
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                onPrimary: Colors.black,
              ),
              icon: Icon(Icons.camera_alt_outlined),
              label: Text('Start Scan'),
            ),
            SizedBox(height: 50),
            Text(
              scanResult == null
                  ? "Scan a mode"
                  : "Scan a result ${scanResult}",
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
