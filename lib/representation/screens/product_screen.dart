import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';

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
                          SizedBox(height: kDefaultPadding),
                          Expanded(
                            flex: 6,
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
                                          Text('ID',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600)),
                                          Text('Name',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600)),
                                          Text('Code',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: ListView.builder(
                                            itemCount: stations.length,
                                            itemBuilder: (context, index) {
                                              final item = stations[index];
                                              return ListTile(
                                                title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('${item.id}'),
                                                      Text(item.product_name),
                                                      Text(
                                                          '${item.product_code}')
                                                    ]),
                                              );
                                            }))
                                  ],
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
  Station(9, 'Orange', 003),
  Station(10, 'Orange', 003),
  Station(11, 'Orange', 003),
  Station(12, 'Orange', 003),
  Station(13, 'Orange', 003),
  Station(14, 'Orange', 003),
  Station(15, 'Orange', 003),
  Station(16, 'Orange', 003),
  Station(17, 'Orange', 003),
  Station(18, 'Orange', 003),
  Station(19, 'Orange', 003),
  Station(20, 'Orange', 003),
  Station(21, 'Orange', 003),
];
