// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:another_flushbar/flushbar.dart';
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
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: ColorPalette.primaryColor, // background
        onPrimary: Colors.white, // foreground
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorPalette.primaryColor),
        child: Text(title, style: TextStyles.defaultStyle.bold.whiteTextColor),
      ),
    );
  }
}
// class ButtonWidget extends StatefulWidget {
//   String title;
//   Function()? onTap;
//   ButtonWidget({
//     Key? key,
//     required this.title,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   State<ButtonWidget> createState() => _ButtonWidgetState();
// }

// class _ButtonWidgetState extends State<ButtonWidget> {
//   bool isLoading = false;

//   void simulateLoading() {
//     setState(() {
//       isLoading = true;
//     });

//     Future.delayed(Duration(seconds: 0)).then((_) {
//       setState(() {
//         isLoading = false;
//       });
//       widget.onTap;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (!isLoading) {
//           simulateLoading();
//         }
//       },
//       child: Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.symmetric(
//             vertical: kDefaultPadding, horizontal: 5),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: ColorPalette.primaryColor),
//         child: isLoading
//             ? CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//               )
//             : Text(widget.title,
//                 style: TextStyles.defaultStyle.bold.whiteTextColor),
//       ),
//     );
//   }
// }
