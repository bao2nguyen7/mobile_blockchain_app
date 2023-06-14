import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/core/constants/textstyle_constants.dart';
import 'package:mobile_app_blockchain/features/home/components/categories.dart';
import 'package:mobile_app_blockchain/features/widgets/listView_widget.dart';
import 'package:mobile_app_blockchain/features/widgets/single_product.dart';
import 'package:mobile_app_blockchain/utils/constans.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/dismenssion_constants.dart';
import '../../../core/helpers/assets_helper.dart';
import '../../../core/helpers/image_helper.dart';
import '../../../models/process.dart';
import '../../../models/product.dart';
import '../../../providers/user_providers.dart';
import '../../newfeed/screens/newfeed.dart';
import '../../newfeed/screens/newfeed_detail.dart';
import '../../newfeed/services/process_services.dart';
import '../../product/screens/add_product_screen.dart';
import '../../product/screens/detail_product_screen.dart';
import '../../product/services/product_serviecs.dart';
import '../../widgets/btn_widget.dart';
import '../../widgets/loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductServices productServices = ProductServices();
  final ProcessServices processServices = ProcessServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchProduct();
    fetchProcess();
  }

  bool isLoading = true;

  List<Product>? product = [];
  Future fetchProduct() async {
    product = await productServices.fetchAllProducts(context: context);
    setState(() {});
    // print(product);
  }

  List<Process>? process = [];
  Future fetchProcess() async {
    process = await processServices.fetchAllProcess(context: context);
    setState(() {});
    // print(product);
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: ColorPalette.primaryColor,
    );
    final user = Provider.of<UserProvider>(context).user;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        titleSpacing: 20,
        title: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    text: "Hi Famer, ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                        fontSize: 20),
                    children: <TextSpan>[
                      TextSpan(
                          text: user.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 18))
                    ]),
              ),
              SizedBox(height: 5),
              Text(
                'Have a good day',
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),
          Spacer(),
          Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                Radius.circular(kItemPadding),
              )),
              padding: EdgeInsets.all(kItemPadding),
              child: ImageHelper.loadFromAsset(AssetsHelper.account))
        ]),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
          constraints: BoxConstraints(
            maxHeight: size.height,
            maxWidth: size.width,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Container(
                width: double.infinity,
                height: size.height,
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
                        flex: 2,
                        child: Container(
                          width: size.width,
                          height: kMaxbtnSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(kDefaultPadding)),
                              color: Color.fromARGB(255, 216, 237, 225)),
                          child: Categories(),
                        ),
                      ),
                      SizedBox(height: kDefaultPadding),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Popular product",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                              ),
                              TextButton(
                                style: flatButtonStyle,
                                onPressed: () {},
                                child: Text(
                                  "More",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 160,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: product!.length,
                                itemBuilder: (context, index) {
                                  final item = product![index];
                                  return Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 232, 228, 224),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 209, 205, 205)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        SingleProduct(
                                            image: item.images.length > 0
                                                ? item.images[0]
                                                : Constants.loading,
                                            height: 120),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          item.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.5),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "New Feed",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          TextButton(
                            style: flatButtonStyle,
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(NewFeedScreen.routeName);
                            },
                            child: Text(
                              "More",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        flex: 6,
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
                              child: process == null
                                  ? Loader()
                                  : Visibility(
                                      visible: isLoading,
                                      child: GridView.builder(
                                        itemCount: process!.length,
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
                                          final processData = process![index];
                                          print(processData);
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NewFeedDetailScreen(
                                                            process:
                                                                processData,
                                                          )));
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: SingleProduct(
                                                        image: processData
                                                                    .stageProcess!
                                                                    .images!
                                                                    .length >
                                                                0
                                                            ? processData
                                                                .stageProcess!
                                                                .images![0]
                                                            : Constants.loading,
                                                        height: 120),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          processData
                                                              .stageProcess!
                                                              .name as String,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge,
                                                        ),
                                                        // Row(
                                                        //   mainAxisAlignment:
                                                        //       MainAxisAlignment
                                                        //           .center,
                                                        //   children: [
                                                        //     Icon(
                                                        //         Icons.add_location),
                                                        //     SizedBox(width: 5),
                                                        //     Text(
                                                        //       processData.address,
                                                        //       style: TextStyle(
                                                        //           fontSize: 10),
                                                        //     )
                                                        //   ],
                                                        // )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )),
                            ),
                          ),
                        )),
                      ),
                    ],
                  ),
                )),
          )),
    );
  }
}
