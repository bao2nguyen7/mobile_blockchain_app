import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/features/widgets/loader.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/dismenssion_constants.dart';
import '../../../models/product.dart';
import '../../../models/productSC.dart';
import '../services/product_serviecs.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});
  static const String routeName = '/journal_screen';
  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final ProductServices productServices = ProductServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProduct();
  }

  List<ProductSC>? product;
  Future fetchProduct() async {
    product = await productServices.fetchAllProductsSC(context: context);
    setState(() {});
    // print(product);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 20,
        title: Text(
          "Journal",
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
        child: Column(children: [
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
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Container(
                      child: product == null
                          ? Loader()
                          : Visibility(
                              child: RefreshIndicator(
                                onRefresh: fetchProduct,
                                child: ListView.builder(
                                    itemCount: product!.length,
                                    itemBuilder: (context, index) {
                                      final productSC = product![index];
                                      return Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: ListTile(
                                            title: Text(
                                              productSC.name,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            subtitle: Text(
                                              productSC.address,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            trailing: Text(
                                              productSC.status == 0
                                                  ? "CREATED"
                                                  : productSC.status == 1
                                                      ? "UPDATED"
                                                      : productSC.status == 2
                                                          ? "DELETED"
                                                          : productSC.status ==
                                                                  3
                                                              ? "DELIVERED"
                                                              : "",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            )),
                ),
              ))
        ]),
      ),
    );
  }
}
