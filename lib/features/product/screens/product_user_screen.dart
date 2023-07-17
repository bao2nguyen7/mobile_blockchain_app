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
import '../../user/home_user/screens/main_app_screen.dart';
import '../../widgets/btn_widget.dart';
import '../../widgets/loader.dart';
import '../../widgets/single_product.dart';
import '../services/product_serviecs.dart';
import 'detail_product_screen.dart';

class ProductUserScreen extends StatefulWidget {
  const ProductUserScreen({super.key});
  static const String routeName = '/product_user_screen';
  @override
  State<ProductUserScreen> createState() => _ProductUserScreenState();
}

class _ProductUserScreenState extends State<ProductUserScreen> {
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

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  bool isLoading = true;
  List<Product>? product;
  Future fetchProduct() async {
    product = await productServices.fetchAllProductsUser(context: context);
    if (mounted) {
      setState(() {});
    }
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
    final user = Provider.of<UserProvider>(context).user;
    if (shouldReload) {
      fetchProduct();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 20,
        title: Text(
          "Sản phẩm",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
        ),
        elevation: 0,
        backgroundColor: ColorPalette.primaryColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                user.userType != "User"
                    ? Navigator.of(context).pushNamed(MainAppScreen.routeName)
                    : Navigator.of(context)
                        .pushNamed(MainAppUserScreen.routeName);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
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
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: SingleProduct(
                                                          image: productData
                                                              .images[0],
                                                          height: 150),
                                                    ),
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
                                                          style:
                                                              Theme.of(context)
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
                                )),
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}
