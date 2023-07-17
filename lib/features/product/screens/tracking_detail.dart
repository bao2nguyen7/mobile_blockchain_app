// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/color_constants.dart';
import '../../../models/tracking.dart';
import '../../../utils/constans.dart';
import '../../../utils/utils.dart';

class TrackingDetailScreen extends StatefulWidget {
  Tracking tracking;
  TrackingDetailScreen({
    Key? key,
    required this.tracking,
  }) : super(key: key);
  @override
  State<TrackingDetailScreen> createState() => _TrackingDetailScreenState();
}

class _TrackingDetailScreenState extends State<TrackingDetailScreen> {
  _launchURL() async {
    String url = widget.tracking.url;
    var urllaunchable =
        await canLaunch(url); //canLaunch is from url_launcher package
    if (urllaunchable) {
      await launch(url); //launch is from url_launcher package to launch URL
    } else {
      print("URL can't be launched.");
      ;
      showSnackBar(context, "URL can't be launched");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tracking.name),
        backgroundColor: ColorPalette.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return FancyShimmerImage(
                    width: double.infinity,
                    imageUrl: widget.tracking!.images![index].toString(),
                    boxFit: BoxFit.scaleDown,
                  );
                },
                autoplay: true,
                itemCount: widget.tracking!.images!.length,
                pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: Colors.red,
                  ),
                ),
                // control: const SwiperControl(),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: EdgeInsets.all(13),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                color: ColorPalette.primaryColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "Tên theo dõi",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        RichText(
                            text: TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _launchURL,
                                text: "Kiểm tra",
                                style: TextStyle(
                                    color: ColorPalette.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)))
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      widget.tracking.name,
                      style: TextStyle(color: Colors.black, fontSize: 32),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        Text(
                          "Thời gian được tạo: ",
                          style: TextStyle(
                            color: Colors.black38,
                          ),
                        ),
                        Text(
                          widget.tracking.time,
                          style: TextStyle(color: Colors.black38),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: ColorPalette.primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        "Mô tả",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 5.0,
                    // ),
                    // widget.tracking.notes.length != 0
                    //     ? Container(
                    //         height: 100,
                    //         child: ListView.builder(
                    //             itemCount: widget.tracking.notes.length,
                    //             itemBuilder: (context, index) {
                    //               return ListTile(
                    //                 title: Padding(
                    //                   padding: const EdgeInsets.symmetric(
                    //                       vertical: 5),
                    //                   child: Text(
                    //                     widget.tracking.notes[index],
                    //                     style: TextStyle(
                    //                       fontWeight: FontWeight.bold,
                    //                       fontSize: 16.0,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               );
                    //             }),
                    //       )
                    //     : SizedBox(),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      widget.tracking.description,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
