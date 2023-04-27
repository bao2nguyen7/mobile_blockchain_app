import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/features/product/screens/infor_product_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/add_product_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/updateInfor_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/dismenssion_constants.dart';
import '../../../core/helpers/assets_helper.dart';
import '../../../core/helpers/image_helper.dart';
import '../../../models/product.dart';
import '../../../providers/user_providers.dart';
import '../../widgets/btn_widget.dart';
import '../../widgets/loader.dart';
import '../../widgets/single_product.dart';
import '../services/product_serviecs.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user.products;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                    child: SafeArea(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(kMediumPadding),
                                topRight: Radius.circular(kMediumPadding))),
                        child: Padding(
                            padding: const EdgeInsets.all(kDefaultPadding),
                            child: Container(
                              child: user == null
                                  ? Loader()
                                  : GridView.builder(
                                      itemCount: user!.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 5),
                                      itemBuilder: (context, index) {
                                        final productData = user![index];
                                        // return Column(
                                        //   children: [
                                        //     SizedBox(
                                        //       height: 140,
                                        //       child: SingleProduct(
                                        //         image: productData.images[0],
                                        //       ),
                                        //     ),
                                        //     Row(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.spaceEvenly,
                                        //       children: [
                                        //         Expanded(
                                        //           child: Text(
                                        //             productData.name,
                                        //             overflow: TextOverflow.ellipsis,
                                        //             maxLines: 2,
                                        //           ),
                                        //         ),
                                        //         IconButton(
                                        //           onPressed: () {},
                                        //           // => deleteProduct(productData, index),
                                        //           icon: const Icon(
                                        //             Icons.delete_outline,
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ],
                                        // );
                                        return GestureDetector(
                                          onTap: () {
                                            //here you can add youy action on grid element Tab
                                          },
                                          child: Card(
                                            child: Stack(
                                              alignment:
                                                  FractionalOffset.bottomCenter,
                                              children: <Widget>[
                                                SingleProduct(
                                                    image:
                                                        productData.images[0]),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: 30.0,
                                                  color: Color.fromARGB(
                                                      255, 86, 198, 157),
                                                  child: Text(
                                                    productData.name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16.0,
                                                        color: Colors.white),
                                                  ),
                                                )
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
