import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/utils/constans.dart';

import '../../../models/process.dart';

class NewFeedDetailScreen extends StatefulWidget {
  const NewFeedDetailScreen({super.key});
  static const String routeName = '/new_feed_detail_screen';
  @override
  State<NewFeedDetailScreen> createState() => _NewFeedDetailScreenState();
}

class _NewFeedDetailScreenState extends State<NewFeedDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final ProcessDetailsArguments arguments =
        ModalRoute.of(context)!.settings.arguments as ProcessDetailsArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.process.name),
        backgroundColor: ColorPalette.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                      imageUrl: arguments.process!.images![index].toString(),
                      boxFit: BoxFit.fill,
                    );
                  },
                  autoplay: true,
                  itemCount: arguments.process!.images!.length,
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
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: ColorPalette.primaryColor,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  arguments.process.name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                arguments.process.description,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProcessDetailsArguments {
  final Process process;

  ProcessDetailsArguments({required this.process});
}
