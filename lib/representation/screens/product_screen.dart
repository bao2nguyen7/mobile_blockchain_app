import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/representation/screens/information_screen.dart';

import '../../core/constants/dismenssion_constants.dart';
import '../../core/helpers/assets_helper.dart';
import '../../core/helpers/image_helper.dart';
import '../widgets/btn_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});
  static String routeName = '/product_screen';
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
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
                      padding: const EdgeInsets.all(30),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: kDefaultPadding * 2),
                        child: Center(
                          child: Text(
                            'Product Details',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      )),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(kMediumPadding),
                            topRight: Radius.circular(kMediumPadding))),
                    child: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(InformationScreen.routeName);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 110,
                                  height: 39,
                                  decoration: BoxDecoration(
                                      color: ColorPalette.primaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: Text(
                                    'Add',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: kDefaultPadding),
                          Expanded(
                              child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: ColorPalette.backgroundScaffoldColor,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(kMediumPadding))),
                            child: ListView.builder(
                                itemCount: stations.length,
                                itemBuilder: (context, index) {
                                  final item = stations[index];
                                  return ListTile(
                                    onTap: () {},
                                    leading: CircleAvatar(
                                        backgroundColor:
                                            ColorPalette.primaryColor,
                                        child: Text(
                                          '${item.id}',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    title: Text('${item.product_name}'),
                                    subtitle:
                                        Text('${item.product_description}'),
                                    trailing:
                                        PopupMenuButton(itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                            child: Text('Edit'), value: 'edit'),
                                        PopupMenuItem(
                                            child: Text('Delete'),
                                            value: 'delete'),
                                      ];
                                    }),
                                  );
                                }),
                          )),
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
  String product_description;
  Station(this.id, this.product_name, this.product_description);
}

List<Station> stations = [
  Station(1, 'Orange', 'good'),
  Station(2, 'Orange', 'bad'),
  Station(3, 'Orange', 'bad'),
  Station(4, 'Orange', 'bad'),
  Station(5, 'Orange', 'bad'),
  Station(6, 'Orange', 'bad'),
  Station(7, 'Orange', 'bad'),
  Station(8, 'Orange', 'bad'),
  Station(9, 'Orange', 'bad'),
  Station(10, 'Orange', 'bad'),
  Station(11, 'Orange', 'bad'),
  Station(12, 'Orange', 'good'),
  Station(13, 'Orange', 'good'),
  Station(14, 'Orange', 'good'),
  Station(15, 'Orange', 'good'),
  Station(16, 'Orange', 'good'),
  Station(17, 'Orange', 'good'),
  Station(18, 'Orange', 'good'),
  Station(19, 'Orange', 'good'),
  Station(20, 'Orange', 'good'),
  Station(21, 'Orange', 'good'),
];
