import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/features/product/screens/infor_product_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/add_product_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/add_tracking_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/update_product_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/dismenssion_constants.dart';
import '../../../core/helpers/assets_helper.dart';
import '../../../core/helpers/image_helper.dart';
import '../../../models/product.dart';
import '../../../providers/user_providers.dart';
import '../../home/screens/main_app_screen.dart';
import '../../widgets/btn_widget.dart';
import '../../widgets/loader.dart';
import '../../widgets/single_product.dart';
import '../services/product_serviecs.dart';
import 'detail_product_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});
  static const String routeName = '/product_screen';
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductServices productServices = ProductServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProduct();
  }

  bool isLoading = true;
  List<Product>? product;
  Future fetchProduct() async {
    product = await productServices.fetchAllProducts(context: context);
    setState(() {});
    // print(product);
  }

  void deleteProduct(String _id) {
    productServices.deleteProduct(context: context, id: _id);
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
          "Product",
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
                    child: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Container(
                        child: product == null
                            ? Loader()
                            : Visibility(
                                visible: isLoading,
                                child: RefreshIndicator(
                                  onRefresh: fetchProduct,
                                  child: GridView.builder(
                                    itemCount: product!.length,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.8,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 24,
                                    ),
                                    itemBuilder: (context, index) {
                                      final productData = product![index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DeatilProductScreen(
                                                        product: productData,
                                                      )));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(.1),
                                                blurRadius: 4.0,
                                                spreadRadius: .05,
                                              ), //BoxShadow
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: SingleProduct(
                                                        image: productData
                                                            .images[0],
                                                        height: 120),
                                                  ),
                                                  Transform.translate(
                                                      offset: Offset(60, -40),
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 60,
                                                            vertical: 55),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                Colors.white),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            showModalBottomSheet(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                              .grey[
                                                                          300],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                    ),
                                                                    height: 170,
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            20),
                                                                    child:
                                                                        Container(
                                                                      margin: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              20),
                                                                      child: ListView(
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                        builder: (context) => UpdateProductScreen(
                                                                                              product: productData,
                                                                                            )));
                                                                              },
                                                                              child: Container(
                                                                                height: 50,
                                                                                width: 230,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color.fromARGB(255, 166, 236, 138)),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                  child: Row(children: [
                                                                                    Icon(Icons.edit),
                                                                                    SizedBox(
                                                                                      width: 30,
                                                                                    ),
                                                                                    Text(
                                                                                      "Edit",
                                                                                      style: Theme.of(context).textTheme.labelLarge,
                                                                                    )
                                                                                  ]),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 18,
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () => deleteProduct(productData.id),
                                                                              child: Container(
                                                                                height: 50,
                                                                                width: 230,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color.fromARGB(255, 226, 132, 132)),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                  child: Row(children: [
                                                                                    Icon(Icons.delete),
                                                                                    SizedBox(
                                                                                      width: 30,
                                                                                    ),
                                                                                    Text(
                                                                                      "Delete",
                                                                                      style: Theme.of(context).textTheme.labelLarge,
                                                                                    )
                                                                                  ]),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          // _showAlertDialog(
                                                          //     context,
                                                          //     productData),
                                                          child: Icon(Icons
                                                              .keyboard_control_outlined),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 15,
                                                      width: 140,
                                                      child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text(
                                                          productData.name,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displayMedium,
                                                        ),
                                                      ),
                                                    ),
                                                    // Text(
                                                    //   productData.name,
                                                    //   style: Theme.of(context)
                                                    //       .textTheme
                                                    //       .labelLarge,
                                                    // ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                            Icons.add_location),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          productData.address,
                                                          style: TextStyle(
                                                              fontSize: 10),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )),
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}
