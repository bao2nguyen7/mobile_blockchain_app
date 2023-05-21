import 'package:flutter/material.dart';

class QRCodeResultScreen extends StatefulWidget {
  const QRCodeResultScreen({super.key});
  static const String routeName = '/qrcode_result_screen';
  @override
  State<QRCodeResultScreen> createState() => _QRCodeResultScreenState();
}

class _QRCodeResultScreenState extends State<QRCodeResultScreen> {
  @override
  Widget build(BuildContext context) {
    final DetailsArguments arguments =
        ModalRoute.of(context)!.settings.arguments as DetailsArguments;
    return Scaffold(
        body: Scaffold(
            body: Center(
      child: Text(arguments.id),
    )));
  }
}

class DetailsArguments {
  final String id;

  DetailsArguments({required this.id});
}
