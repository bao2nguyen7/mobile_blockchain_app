// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
import '../../../models/process.dart';
import '../../newfeed/services/process_services.dart';
import '../services/product_serviecs.dart';

class AddTrackingScreen extends StatefulWidget {
  Product product;
  AddTrackingScreen({
    Key? key,
    required this.product,
  }) : super(key: key);
  @override
  State<AddTrackingScreen> createState() => _AddTrackingScreenState();
}

class _AddTrackingScreenState extends State<AddTrackingScreen> {
  TextEditingController _waterTextController = TextEditingController();
  TextEditingController _quantityTextController = TextEditingController();
  TextEditingController _fertilizierTextController = TextEditingController();
  TextEditingController _purchasingunitTextController = TextEditingController();

  TextEditingController _addressTextController = TextEditingController();
  TextEditingController _descriptionTextController = TextEditingController();

  TextEditingController timeinput = TextEditingController();
  final ProductServices productServices = ProductServices();
  final ProcessServices processServices = ProcessServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProcess();
  }

  List<File> images = [];
  List<String> notes = [];

  final _addTrackingFormKey = GlobalKey<FormState>();
  void addTracking() {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    if (_addTrackingFormKey.currentState!.validate() && images.isNotEmpty) {
      if (valueChoose == nameStage()[1]) {
        notes.add("Watering Time " + _waterTextController.text);
        notes.add("Fertilizier " + _fertilizierTextController.text);
      } else if (valueChoose == nameStage()[4]) {
        notes.add("Quantity " + _quantityTextController.text);
      } else if (valueChoose == nameStage()[5]) {
        notes.add("PurchasingUnit " + _purchasingunitTextController.text);
      }
      //pop dialog
      productServices.addTracking(
          id: widget.product.productId,
          context: context,
          name: valueChoose,
          description: _descriptionTextController.text,
          time: timeinput.text,
          images: images,
          notes: notes);
    }
    Navigator.of(context).pop();
  }

  void addTrackingDeliveried() {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    if (_addTrackingFormKey.currentState!.validate() && images.isNotEmpty) {
      if (valueChoose == nameStage()[1]) {
        notes.add("Watering Time " + _waterTextController.text);
        notes.add("Fertilizier " + _fertilizierTextController.text);
      } else if (valueChoose == nameStage()[4]) {
        notes.add("Quantity " + _quantityTextController.text);
      } else if (valueChoose == nameStage()[5]) {
        notes.add("PurchasingUnit " + _purchasingunitTextController.text);
      }
      productServices.addTrackingDeliveried(
          id: widget.product.productId,
          context: context,
          name: valueChoose,
          description: _descriptionTextController.text,
          time: timeinput.text,
          images: images,
          notes: notes);
    }
    Navigator.of(context).pop();
  }

  String valueChoose = "";
  String? stagePlantCare = "";
  String? stageBloom = "";
  String? stageHarvest = "";
  String? stageSell = "";
  String? stagePlantSeed = "";
  String? stageCover = "";
  Process? process;
  Future fetchProcess() async {
    process = await processServices.fetchAllProcessTitle(
        context: context, id: widget.product.processId);
    setState(() {
      stageBloom = process?.stageBloom?.name ?? '';
      stagePlantCare = process?.stagePlantCare?.name ?? '';
      stageHarvest = process?.stageHarvest?.name ?? '';
      stageSell = process?.stageSell?.name ?? '';
      stagePlantSeed = process?.stagePlantSeeds?.name ?? '';
      stageCover = process?.stageCover?.name ?? '';
    });

    // print(process!.stageBloom!.name);
  }

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
                          timeinput.text =
                              "${_chosenDateTime.day.toString()}/${_chosenDateTime.month.toString()}/${_chosenDateTime.year.toString()}";
                        });
                      },
                      mode: CupertinoDatePickerMode.date,
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
          "Thêm theo dõi",
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
                                    reuseableRichText("Tên theo dõi"),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                DropdownButtonFormField2(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    focusColor: ColorPalette.subTitleColor,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        gapPadding: 50),
                                  ),
                                  buttonStyleData: ButtonStyleData(
                                    height: 60,
                                    width: 160,
                                    padding: const EdgeInsets.only(
                                        left: 11, right: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black, width: 0.5),
                                      color: ColorPalette.subTitleColor
                                          .withOpacity(0.3),
                                    ),
                                    elevation: 0,
                                  ),
                                  isExpanded: true,
                                  hint: Row(
                                    children: [
                                      Icon(Icons.brightness_5_outlined,
                                          color: ColorPalette.subTitleColor),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Chọn quy trình',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  items: nameStage()
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Row(
                                              children: [
                                                Icon(
                                                    Icons.brightness_5_outlined,
                                                    color: ColorPalette
                                                        .subTitleColor),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  item as String,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select process.';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      valueChoose = value.toString();
                                      print(valueChoose);
                                    });
                                  },
                                  onSaved: (value) {
                                    valueChoose = value.toString();

                                    print(valueChoose);
                                  },
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    iconSize: 30,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                Container(
                                    child: valueChoose == nameStage()[1]
                                        ? Column(children: [
                                            SizedBox(
                                                height: kDefaultPadding / 2),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                reuseableRichText(
                                                    "Thời gian tưới nước"),
                                              ],
                                            ),
                                            SizedBox(
                                                height: kDefaultPadding / 2),
                                            reusableTextFiledName(
                                                "Thời gian tưới nước",
                                                _waterTextController,
                                                false),
                                            SizedBox(
                                                height: kDefaultPadding / 2),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                reuseableRichText("Phân bón"),
                                              ],
                                            ),
                                            SizedBox(
                                                height: kDefaultPadding / 2),
                                            reusableTextFiledName(
                                                "Phân bón",
                                                _fertilizierTextController,
                                                false),
                                            SizedBox(
                                                height: kDefaultPadding / 2),
                                          ])
                                        : valueChoose == nameStage()[4]
                                            ? Column(children: [
                                                SizedBox(
                                                    height:
                                                        kDefaultPadding / 2),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    reuseableRichText(
                                                        "Số lượng"),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        kDefaultPadding / 2),
                                                reusableTextFiledName(
                                                    "Số lượng",
                                                    _quantityTextController,
                                                    false),
                                                SizedBox(
                                                    height:
                                                        kDefaultPadding / 2),
                                              ])
                                            : valueChoose == nameStage()[5]
                                                ? Column(children: [
                                                    SizedBox(
                                                        height:
                                                            kDefaultPadding /
                                                                2),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        reuseableRichText(
                                                            "Đơn vị mua hàng"),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            kDefaultPadding /
                                                                2),
                                                    reusableTextFiledName(
                                                        "Đơn vị mua hàng",
                                                        _purchasingunitTextController,
                                                        false),
                                                    SizedBox(
                                                        height:
                                                            kDefaultPadding /
                                                                2),
                                                  ])
                                                : null),
                                SizedBox(height: kDefaultPadding / 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    reuseableRichText("Thời gian"),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                TextFormField(
                                    controller: timeinput,
                                    decoration: InputDecoration(
                                        labelText: "Thời gian",
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
                                    reuseableRichText("Hình ảnh"),
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
                                                  'Chọn hình ảnh sản phẩm',
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
                                    reuseableRichText("Mô tả"),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                reusableTextFiledName(
                                    "Mô tả", _descriptionTextController, true),
                                SizedBox(height: kDefaultPadding * 2),
                                valueChoose == nameStage()[5]
                                    ? ButtonWidget(
                                        title: "Vận chuyển",
                                        onTap: addTrackingDeliveried,
                                      )
                                    : ButtonWidget(
                                        title: "Cập nhật",
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
