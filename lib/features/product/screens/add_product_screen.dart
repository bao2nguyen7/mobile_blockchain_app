import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/core/helpers/assets_helper.dart';
import 'package:mobile_app_blockchain/core/helpers/image_helper.dart';
import 'package:mobile_app_blockchain/features/widgets/button_widgets.dart';
import 'package:mobile_app_blockchain/features/widgets/richText_widget.dart';
import 'package:mobile_app_blockchain/features/widgets/textfieldName_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/dismenssion_constants.dart';
import '../../../core/constants/utils.dart';
import '../../../models/product.dart';
import '../../../models/user.dart';
import '../../../models/process.dart';
import '../../../providers/user_providers.dart';
import '../../newfeed/services/process_services.dart';
import '../services/product_serviecs.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  static const String routeName = '/addProduct_screen';
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  _AddProductScreenState() {
    valueChoose = "Process";
  }
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();
  TextEditingController _descriptionTextController = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  final ProductServices productServices = ProductServices();
  final ProcessServices processServices = ProcessServices();
  @override
  @override
  void initState() {
    // TODO: implement initState
    timeinput.text = "";
    super.initState();
    fetchProcess();
  }

  String valueChoose = "";

  List<Process> process = [];
  Future fetchProcess() async {
    process = await processServices.fetchAllProcess(context: context);
    if (mounted) {
      setState(() {});
    }
  }

  List<File> images = [];
  List<File> certificate = [];
  final _addProductFormKey = GlobalKey<FormState>();
  //add-Product
  void addProduct() {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      productServices.addProduct(
          context: context,
          name: _nameTextController.text,
          description: _descriptionTextController.text,
          address: _addressTextController.text,
          processId: valueChoose,
          time: timeinput.text,
          images: images,
          certificates: certificate);
    }
    Navigator.of(context).pop();
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void selectImagesCertificate() async {
    var res = await pickImages();
    setState(() {
      certificate = res;
    });
    print(certificate);
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

//  var processName = process.map
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
          "Thêm sản phẩm",
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
                      key: _addProductFormKey,
                      child: Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: kDefaultPadding),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    reuseableRichText("Tên sản phẩm"),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                reusableTextFiledName(
                                    "Tên sản phẩm", _nameTextController, false),
                                SizedBox(height: kDefaultPadding),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    reuseableRichText("Địa chỉ"),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                reusableTextFiledName(
                                    "Địa chỉ", _addressTextController, false),
                                SizedBox(height: kDefaultPadding),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    reuseableRichText("Qui trình"),
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
                                    width: 170,
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
                                        'Chọn qui trình',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  items: process
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item.sId,
                                            child: Row(
                                              children: [
                                                Icon(
                                                    Icons.brightness_5_outlined,
                                                    color: ColorPalette
                                                        .subTitleColor),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  width: 270,
                                                  child: Text(
                                                    item.stageProcess!.name
                                                        as String,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Hãy chọn qui trình.';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      valueChoose = value.toString();
                                    });
                                  },
                                  onSaved: (value) {
                                    valueChoose = value.toString();
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
                                SizedBox(height: kDefaultPadding),
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
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Không thể thiếu';
                                      }
                                      if (text.length < 2) {
                                        return 'Quá ngắn';
                                      }
                                      return null;
                                    },
                                    readOnly:
                                        true, //set it true, so that user will not able to edit text
                                    onTap: () => _showDatePicker(context)),
                                SizedBox(height: kDefaultPadding * 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    reuseableRichText("Hình ảnh sản phẩm"),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                images.isNotEmpty
                                    ? GestureDetector(
                                        onTap: selectImages,
                                        child: CarouselSlider(
                                          items: images.map(
                                            (i) {
                                              return Builder(
                                                builder:
                                                    (BuildContext context) =>
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
                                                  'Chọn hình ảnh',
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
                                    reuseableRichTextNo("Hình ảnh chứng chỉ"),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                certificate.isNotEmpty
                                    ? GestureDetector(
                                        onTap: selectImagesCertificate,
                                        child: CarouselSlider(
                                          items: certificate.map(
                                            (i) {
                                              return Builder(
                                                builder:
                                                    (BuildContext context) =>
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
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: selectImagesCertificate,
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
                                                  'Chọn hình ảnh',
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
                                  title: "Thêm",
                                  onTap: addProduct,
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
