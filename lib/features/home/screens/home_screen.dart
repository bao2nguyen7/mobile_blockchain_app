import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/core/constants/textstyle_constants.dart';
import 'package:mobile_app_blockchain/features/widgets/listView_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/dismenssion_constants.dart';
import '../../../core/helpers/assets_helper.dart';
import '../../../core/helpers/image_helper.dart';
import '../../../providers/user_providers.dart';
import '../../product/screens/add_product_screen.dart';
import '../../widgets/btn_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
                flex: 2,
                child: Container(
                  color: ColorPalette.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 30),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 35),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: "Hi, ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: user.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 18))
                                      ]),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Have a good day',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(kItemPadding),
                                )),
                                padding: EdgeInsets.all(kItemPadding),
                                child: ImageHelper.loadFromAsset(
                                    AssetsHelper.account)),
                          )
                        ]),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(kMediumPadding),
                            topRight: Radius.circular(kMediumPadding))),
                    child: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Column(
                        children: [
                          SizedBox(height: kDefaultPadding * 2),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BtnWidget(
                                    title: 'Create QR Code',
                                    image: ImageHelper.loadFromAsset(
                                        AssetsHelper.qr_code),
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          AddProductScreen.routeName);
                                    }),
                                SizedBox(width: 40),
                                BtnWidget(
                                    title: 'Choose planting process',
                                    image: ImageHelper.loadFromAsset(
                                        AssetsHelper.iconcty),
                                    onTap: () {}),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: SafeArea(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: ColorPalette.backgroundScaffoldColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(kMediumPadding))),
                                child: Padding(
                                  padding: const EdgeInsets.all(kMediumPadding),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: kDefaultPadding / 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Name',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text('Time',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text('Status',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: ListView.builder(
                                              itemCount: user.products.length,
                                              itemBuilder: (context, index) {
                                                final item =
                                                    user.products[index];
                                                return ListTile(
                                                  title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        // Text('${item.}'),
                                                        Text(item.name),
                                                        Text(item.time)
                                                        // Text(
                                                        //     '${item.product_code}')
                                                      ]),
                                                );
                                              }))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              )
            ],
          )),
    );
  }
}

class Station {
  int id;
  String product_name;
  int product_code;
  Station(this.id, this.product_name, this.product_code);
}

List<Station> stations = [
  Station(1, 'Orange', 001),
  Station(2, 'Orange', 002),
  Station(3, 'Orange', 003),
  Station(4, 'Orange', 003),
  Station(5, 'Orange', 003),
  Station(6, 'Orange', 003),
  Station(7, 'Orange', 003),
  Station(8, 'Orange', 003),
];
