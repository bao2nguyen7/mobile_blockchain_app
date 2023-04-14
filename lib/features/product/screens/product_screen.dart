import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/features/product/screens/infor_product_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/information_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/updateInfor_screen.dart';

import '../../../core/constants/dismenssion_constants.dart';
import '../../../core/helpers/assets_helper.dart';
import '../../../core/helpers/image_helper.dart';
import '../../widgets/btn_widget.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        titleSpacing: 20,
        title: Text(
          "Product Details",
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
                  child: SafeArea(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(kMediumPadding),
                                topRight: Radius.circular(kMediumPadding))),
                        child: Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: Column(
                            children: [
                              // SizedBox(height: 5),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: stations.length,
                                    scrollDirection: Axis.vertical,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final item = stations[index];
                                      return Card(
                                        color:
                                            Color.fromARGB(255, 246, 242, 242),
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                InforProductScreen.routeName);
                                            print(Text("Hello"));
                                          },
                                          leading: CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 86, 222, 143),
                                              child: Text(
                                                '${item.id}',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                          title: Text(
                                            '${item.product_name}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          subtitle: Text(
                                              '${item.product_description}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300)),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            UpdateInformationScreen
                                                                .routeName);
                                                  },
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: Color.fromARGB(
                                                        255, 105, 226, 155),
                                                  )),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      stations.removeAt(index);
                                                    });
                                                  },
                                                  icon: const Icon(Icons.delete,
                                                      color: Color.fromARGB(
                                                          255, 105, 226, 155))),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
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
