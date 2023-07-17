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
import 'package:mobile_app_blockchain/features/product/screens/product_screen.dart';
import 'package:mobile_app_blockchain/features/widgets/button_widgets.dart';
import 'package:mobile_app_blockchain/features/widgets/richText_widget.dart';
import 'package:mobile_app_blockchain/features/widgets/textfieldName_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/dismenssion_constants.dart';
import '../../../core/constants/utils.dart';
import '../../../models/product.dart';
import '../../../models/tracking.dart';
import '../../../models/user.dart';
import '../../../models/process.dart';
import '../../../providers/user_providers.dart';
import '../../../utils/utils.dart';
import '../../newfeed/services/process_services.dart';
import '../../widgets/loader.dart';
import '../services/product_serviecs.dart';

class UpdateProductScreen extends StatefulWidget {
  Product product;
  UpdateProductScreen({
    required this.product,
  });
  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  _UpdateProductScreenState() {
    valueChoose = "Process";
  }
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();
  TextEditingController _descriptionTextController = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  final ProductServices productServices = ProductServices();
  final ProcessServices processServices = ProcessServices();
  String id = '';
  String processProductID = "";
  String productId = '';
  List<String> images = [];
  List<String> certificate = [];
  int? productNumber = 0;
  Future fetchDetailProduct() async {
    productNumber = await productServices.fetchDetailProductsBC(
        context: context, id: widget.product.productId);
    setState(() {});
  }

  List<Tracking> tracking = [];
  Future fetchTracking() async {
    tracking = await productServices.fetchAllTracking(
        context: context, id: widget.product.productId);
    if (mounted) {
      setState(() {});
    }
  }

  void initState() {
    // TODO: implement initState
    fetchProcess();
    fetchProcesses();
    fetchTracking();
    print("Tracking");

    setState(() {
      _nameTextController.text = widget.product.name;
      _addressTextController.text = widget.product.address;
      _descriptionTextController.text = widget.product.description;
      timeinput.text = widget.product.time;
      images = widget.product.images;
      certificate = widget.product.certificates;
      valueChoose = stageProcessName as String;
      id = widget.product.id;
      productId = widget.product.productId;
      processProductID = widget.product.processId;
    });
    super.initState();
  }

  final _updateProductFormKey = GlobalKey<FormState>();
  //update-Product
  void updateProduct() {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    if (_updateProductFormKey.currentState!.validate() && images.isNotEmpty) {
      productServices.updateProduct(
          context: context,
          id: id,
          name: _nameTextController.text,
          description: _descriptionTextController.text,
          address: _addressTextController.text,
          time: timeinput.text,
          processId: processProductID,
          images: images,
          productId: productId,
          certificate: certificate);
    }
  }

  String valueChoose = "";
  String? stagePlantCare = "";
  String? stageBloom = "";
  String? stageHarvest = "";
  String? stageSell = "";
  String? stagePlantSeed = "";
  String? stageCover = "";
  String? stageProcessName = "";

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
      stageProcessName = process?.stageProcess?.name ?? '';
    });
  }
  // List<File> imagess = [];
  // void selectImages() async {
  //   var res = await pickImages();
  //   setState(() {
  //     imagess = res;
  //   });
  // }

  List<Process> processes = [];
  Future fetchProcesses() async {
    processes = await processServices.fetchAllProcess(context: context);
    setState(() {});
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameTextController.dispose();
    _addressTextController.dispose();
    _descriptionTextController.dispose();
    timeinput.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cập nhật sản phẩm",
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
                      key: _updateProductFormKey,
                      child: Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: kDefaultPadding),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    reuseableRichText("Tên sản phẩm:"),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                reusableTextFiledName(
                                    "Tên sản phẩm", _nameTextController, false),
                                SizedBox(height: kDefaultPadding / 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    reuseableRichText("Địa chỉ"),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                reusableTextFiledName(
                                    "Địa chỉ", _addressTextController, false),
                                SizedBox(height: kDefaultPadding / 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    reuseableRichText("Quá trình"),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                tracking.length == 0
                                    ? DropdownButtonFormField2(
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.zero,
                                          focusColor:
                                              ColorPalette.subTitleColor,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gapPadding: 50),
                                        ),
                                        buttonStyleData: ButtonStyleData(
                                          height: 60,
                                          width: 160,
                                          padding: const EdgeInsets.only(
                                              left: 11, right: 16),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 0.5),
                                            color: ColorPalette.subTitleColor
                                                .withOpacity(0.3),
                                          ),
                                          elevation: 0,
                                        ),
                                        isExpanded: true,
                                        hint: Row(
                                          children: [
                                            Icon(Icons.brightness_5_outlined,
                                                color:
                                                    ColorPalette.subTitleColor),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              stageProcessName as String,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        items: processes
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item.sId,
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .brightness_5_outlined,
                                                          color: ColorPalette
                                                              .subTitleColor),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        item.stageProcess!.name
                                                            as String,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            processProductID = value.toString();
                                          });
                                        },
                                        onSaved: (value) {
                                          processProductID = value.toString();

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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      )
                                    : DropdownButtonFormField2(
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.zero,
                                          focusColor:
                                              ColorPalette.subTitleColor,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gapPadding: 50),
                                        ),
                                        buttonStyleData: ButtonStyleData(
                                          height: 60,
                                          width: 160,
                                          padding: const EdgeInsets.only(
                                              left: 11, right: 16),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 0.5),
                                            color: ColorPalette.subTitleColor
                                                .withOpacity(0.3),
                                          ),
                                          elevation: 0,
                                        ),
                                        isExpanded: true,
                                        hint: Row(
                                          children: [
                                            Icon(Icons.brightness_5_outlined,
                                                color:
                                                    ColorPalette.subTitleColor),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              stageProcessName as String,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        items: processes
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item.sId,
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .brightness_5_outlined,
                                                          color: ColorPalette
                                                              .subTitleColor),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        item.stageProcess!.name
                                                            as String,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black45,
                                          ),
                                          iconSize: 30,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                SizedBox(height: kDefaultPadding / 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    reuseableRichText("Thời gian "),
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
                                                  Image.network(
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
                                        // onTap: selectImages,
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
                                ButtonWidget(
                                    title: "Cập nhật", onTap: updateProduct
                                    // addProduct,
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
