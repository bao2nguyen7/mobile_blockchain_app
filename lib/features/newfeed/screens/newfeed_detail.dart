// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:casa_vertical_stepper/casa_vertical_stepper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/utils/constans.dart';

import '../../../models/process.dart';
import '../services/process_services.dart';

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
  final ProcessServices processServices = ProcessServices();
  List<Process> processes = [];
  Future fetchProcess() async {
    processes = await processServices.fetchAllProcess(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.process.stageProcess!.name as String),
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
                      imageUrl: widget.process!.stageProcess!.images![index]
                          .toString(),
                      boxFit: BoxFit.contain,
                    );
                  },
                  autoplay: true,
                  itemCount: widget.process!.stageProcess!.images!.length,
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

              TabBar(
                indicatorColor: ColorPalette.primaryColor,
                tabs: <Widget>[
                  Tab(
                    text: ("Thông tin quá trình"),
                  ),
                  Tab(
                    text: ("Quy trình quá trình"),
                  ),
                ],
              ),
              Container(
                constraints: BoxConstraints(
                  maxHeight: 8000,
                  maxWidth: size.width,
                ),
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              widget.process.stageProcess!.name as String,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                widget.process.stageProcess!.description
                                    as String,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 3, right: 5),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: ColorPalette.primaryColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black26)),
                              ),
                              Text(
                                  widget.process.stagePlantSeeds!.name
                                      as String,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 17),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 40),
                            decoration: const BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                              color: Color.fromARGB(255, 65, 105, 63),
                            ))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mô tả:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(widget.process.stagePlantSeeds!.description
                                    as String)
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 3, right: 5),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.amberAccent,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black26)),
                              ),
                              Text(
                                  widget.process.stagePlantCare!.name as String,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 17),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 40),
                            decoration: const BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                              color: Color.fromARGB(255, 65, 105, 63),
                            ))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mô tả:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(widget.process.stagePlantCare!.description
                                    as String),
                                SizedBox(
                                  height: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Lượng nước:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(widget.process.stagePlantCare!.water
                                        as String),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Phân bón:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(widget.process.stagePlantCare!
                                        .fertilizer as String)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 3, right: 5),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 71, 196, 205),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black26)),
                              ),
                              Text(widget.process.stageBloom!.name as String,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 17),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 40),
                            decoration: const BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                              color: Color.fromARGB(255, 65, 105, 63),
                            ))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mô tả:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(widget.process.stageBloom!.description
                                    as String)
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 3, right: 5),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 40, 17, 213),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black26)),
                              ),
                              Text(widget.process.stageCover!.name as String,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 17),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 40),
                            decoration: const BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                              color: Color.fromARGB(255, 65, 105, 63),
                            ))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mô tả:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(widget.process.stageCover!.description
                                    as String)
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 3, right: 5),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 150, 64, 255),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black26)),
                              ),
                              Text(widget.process.stageHarvest!.name as String,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 17),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 40),
                            decoration: const BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                              color: Color.fromARGB(255, 65, 105, 63),
                            ))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mô tả:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(widget.process.stageHarvest!.description
                                    as String),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Text('Số lượng:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(widget.process.stageHarvest!.quantity
                                        as String),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 3, right: 5),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 255, 64, 102),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black26)),
                              ),
                              Text(widget.process.stageSell!.name as String,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 17),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 40),
                            decoration: const BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                              color: Color.fromARGB(255, 65, 105, 63),
                            ))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mô tả:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(widget.process.stageSell!.description
                                    as String),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Text('Quantity:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(widget.process.stageSell!
                                        .purchasingUnit as String),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(5.0),
              //   decoration: BoxDecoration(
              //     color: ColorPalette.primaryColor,
              //     borderRadius: BorderRadius.circular(30.0),
              //   ),
              //   child: Text(
              //     widget.process.stageProcess!.name as String,
              //     style: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 8.0,
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: Text(
              //     widget.process.stageProcess!.description as String,
              //     style: TextStyle(
              //       fontWeight: FontWeight.w300,
              //       fontSize: 16.0,
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
