// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/utils/constans.dart';

import '../../../models/process.dart';

class NewFeedDetailScreen extends StatefulWidget {
  Process process;
  NewFeedDetailScreen({
    Key? key,
    required this.process,
  }) : super(key: key);
  @override
  State<NewFeedDetailScreen> createState() => _NewFeedDetailScreenState();
}

class _NewFeedDetailScreenState extends State<NewFeedDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.process.name),
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
                    imageUrl: widget.process!.images![index].toString(),
                    boxFit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: widget.process!.images!.length,
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
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: ColorPalette.primaryColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                widget.process.name,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.process.description,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
