// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/core/helpers/assets_helper.dart';
import 'package:mobile_app_blockchain/core/helpers/image_helper.dart';
import 'package:mobile_app_blockchain/features/widgets/button_widgets.dart';
import 'package:mobile_app_blockchain/features/widgets/richText_widget.dart';
import 'package:mobile_app_blockchain/features/widgets/textfieldName_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/constants/dismenssion_constants.dart';
import '../../../core/constants/utils.dart';
import '../../../models/product.dart';
import '../services/product_serviecs.dart';

class AddTrackingScreen extends StatefulWidget {
  String id;
  AddTrackingScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  State<AddTrackingScreen> createState() => _AddTrackingScreenState();
}

class _AddTrackingScreenState extends State<AddTrackingScreen> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();
  TextEditingController _descriptionTextController = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  final ProductServices productServices = ProductServices();
  String _id = "";
  @override
  void initState() {
    // TODO: implement initState
    _id = widget.id;
    super.initState();
  }

  List<File> images = [];
  final _addTrackingFormKey = GlobalKey<FormState>();
  void addTracking() {
    if (_addTrackingFormKey.currentState!.validate() && images.isNotEmpty) {
      productServices.addTracking(
        id: _id,
        context: context,
        name: _nameTextController.text,
        description: _descriptionTextController.text,
        address: _addressTextController.text,
        time: timeinput.text,
        images: images,
      );
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  DateTime _chosenDateTime = DateTime.now();

  // Show the modal that contains the CupertinoDatePicker
  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: CupertinoDatePicker(
                      initialDateTime: _chosenDateTime,
                      onDateTimeChanged: (DateTime val) {
                        setState(() {
                          _chosenDateTime = val;
                          timeinput.text = _chosenDateTime.toString();
                        });
                      },
                      mode: CupertinoDatePickerMode.dateAndTime,
                    ),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Tracking",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
        ),
        elevation: 0,
        backgroundColor: ColorPalette.primaryColor,
      ),
      backgroundColor: ColorPalette.primaryColor,
      body: Container(
          constraints: BoxConstraints(
            maxHeight: size.height,
            maxWidth: size.width,
          ),
          decoration: BoxDecoration(
            color: ColorPalette.primaryColor,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: ColorPalette.primaryColor,
                ),
              ),
              Expanded(
                flex: 25,
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(kMediumPadding),
                            topRight: Radius.circular(kMediumPadding))),
                    child: Form(
                      key: _addTrackingFormKey,
                      child: Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: kDefaultPadding),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    reuseableRichText("Tracking Name"),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                reusableTextFiledName("Tracking Name",
                                    _nameTextController, false),
                                SizedBox(height: kDefaultPadding * 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    reuseableRichText("Address"),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                reusableTextFiledName(
                                    "Address", _addressTextController, false),
                                SizedBox(height: kDefaultPadding * 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    reuseableRichText("Time"),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                TextFormField(
                                    controller: timeinput,
                                    decoration: InputDecoration(
                                        labelText: "Time",
                                        labelStyle: TextStyle(
                                            color: ColorPalette.subTitleColor
                                                .withOpacity(0.9)),
                                        filled: true,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        fillColor: ColorPalette.subTitleColor
                                            .withOpacity(0.3),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                width: 0.5,
                                                style: BorderStyle.solid,
                                                color: Colors.black))),
                                    keyboardType: TextInputType.emailAddress,
                                    readOnly:
                                        true, //set it true, so that user will not able to edit text
                                    onTap: () => _showDatePicker(context)),
                                SizedBox(height: kDefaultPadding * 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    reuseableRichText("Image"),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                images.isNotEmpty
                                    ? CarouselSlider(
                                        items: images.map(
                                          (i) {
                                            return Builder(
                                              builder: (BuildContext context) =>
                                                  Image.file(
                                                i,
                                                fit: BoxFit.cover,
                                                height: 200,
                                              ),
                                            );
                                          },
                                        ).toList(),
                                        options: CarouselOptions(
                                          viewportFraction: 1,
                                          height: 200,
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: selectImages,
                                        child: DottedBorder(
                                          borderType: BorderType.RRect,
                                          radius: const Radius.circular(10),
                                          dashPattern: const [10, 4],
                                          strokeCap: StrokeCap.round,
                                          child: Container(
                                            width: double.infinity,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.folder_open,
                                                  size: 40,
                                                ),
                                                const SizedBox(height: 15),
                                                Text(
                                                  'Select Product Images',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                SizedBox(height: kDefaultPadding * 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    reuseableRichText("Description"),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                reusableTextFiledName("Description",
                                    _descriptionTextController, true),
                                SizedBox(height: kDefaultPadding * 2),
                                ButtonWidget(
                                  title: "Update",
                                  onTap: addTracking,
                                )
                              ],
                            ),
                          )),
                    )),
              )
            ],
          )),
    );
  }
}