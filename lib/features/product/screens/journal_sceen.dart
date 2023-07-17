import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/features/product/screens/detail_product_screen.dart';
import 'package:mobile_app_blockchain/features/widgets/loader.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/dismenssion_constants.dart';
import '../../../models/product.dart';
import '../../../models/productSC.dart';
import '../../widgets/single_product.dart';
import '../services/product_serviecs.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});
  static const String routeName = '/journal_screen';
  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final ProductServices productServices = ProductServices();
  bool shouldReload = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProduct();
    setState(() {
      shouldReload = true;
    });
  }

  List<Product>? product;
  Future fetchProduct() async {
    product = await productServices.fetchAllProductsDelivery(context: context);
    if (mounted) {
      setState(() {});
    }
    // print(product);
  }

  // @override
  // void dispose() {
  //   // Hủy bỏ timer hoặc dừng lắng nghe animation
  //   // Code dispose khác
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (shouldReload) {
      fetchProduct();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 20,
        title: Text(
          "Thu hoạch",
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
                                              color:
                                                  Colors.black.withOpacity(.1),
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
                                                  alignment: Alignment.topRight,
                                                  child: SingleProduct(
                                                      image:
                                                          productData.images[0],
                                                      height: 130),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 15,
                                                    width: 200,
                                                    child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        productData.name,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge,
                                                      ),
                                                    ),
                                                  ),
                                                  // Text(
                                                  //   productData.name,
                                                  //   style: Theme.of(context)
                                                  //       .textTheme
                                                  //       .labelLarge,
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )),
                ),
              ))
        ]),
      ),
    );
  }
}
