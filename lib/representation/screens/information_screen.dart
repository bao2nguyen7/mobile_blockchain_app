import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/core/helpers/assets_helper.dart';
import 'package:mobile_app_blockchain/core/helpers/image_helper.dart';
import 'package:mobile_app_blockchain/representation/widgets/button_widgets.dart';
import 'package:mobile_app_blockchain/representation/widgets/richText_widget.dart';
import 'package:mobile_app_blockchain/representation/widgets/textfieldName_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/constants/dismenssion_constants.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});
  static String routeName = '/information_screen';
  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();
  TextEditingController _descriptionTextController = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    timeinput.text = "";
    super.initState();
  }

  File? _image;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTempogary = File(image.path);
    setState(() {
      this._image = imageTempogary;
    });
  }

  Future takeImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTempogary = File(image.path);
    setState(() {
      this._image = imageTempogary;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              "Choose Image",
              style: TextStyle(fontSize: 25),
            ),
            content: Text("Camera or Gallery", style: TextStyle(fontSize: 15)),
            actions: [
              MaterialButton(onPressed: takeImage, child: Text("Camera")),
              MaterialButton(onPressed: getImage, child: Text("Gallery")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Product",
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
                    child: Container(
                      child: Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: kDefaultPadding),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    reuseableRichText("Product Name"),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                reusableTextFiledName(
                                    "Product Name", _nameTextController, false),
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
                                    onTap: () async {
                                      TimeOfDay? pickedTime =
                                          await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );

                                      if (pickedTime != null) {
                                        print(pickedTime
                                            .format(context)); //output 10:51 PM
                                        DateTime parsedTime = DateFormat.jm()
                                            .parse(pickedTime
                                                .format(context)
                                                .toString());
                                        //converting to DateTime so that we can further format on different pattern.
                                        print(
                                            parsedTime); //output 1970-01-01 22:53:00.000
                                        String formattedTime =
                                            DateFormat('HH:mm:ss')
                                                .format(parsedTime);
                                        print(formattedTime); //output 14:59:00
                                        //DateFormat() is from intl package, you can format the time on any pattern you need.

                                        setState(() {
                                          timeinput.text =
                                              formattedTime; //set the value of text field.
                                        });
                                      } else {
                                        print("Time is not selected");
                                      }
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    // The validator receives the text that the user has entered.
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Can\'t be empty';
                                      }
                                      if (text.length < 2) {
                                        return 'Too short';
                                      }
                                      return null;
                                    }),
                                SizedBox(height: kDefaultPadding * 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    reuseableRichText("Image"),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _image != null
                                        ? Image.file(
                                            _image!,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          )
                                        : ImageHelper.loadFromAsset(
                                            AssetsHelper.logo,
                                            width: 100,
                                            height: 110,
                                            radius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MaterialButton(
                                        onPressed: _showDialog,
                                        color: ColorPalette.primaryColor,
                                        child: Text(
                                          "Choose",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        )),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding * 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    reuseableRichText("Description"),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 2),
                                reusableTextFiledName(
                                    "Description", _nameTextController, true),
                                SizedBox(height: kDefaultPadding * 2),
                                ButtonWidget(title: "Add")
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
