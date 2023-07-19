// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/models/tracking.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/dismenssion_constants.dart';
import '../../../models/process.dart';
import '../../../models/product.dart';
import '../../../providers/user_providers.dart';
import '../../../utils/utils.dart';
import '../../home/screens/main_app_screen.dart';
import '../../newfeed/services/process_services.dart';
import '../../product/screens/add_tracking_screen.dart';
import '../../product/screens/description_detail.dart';
import '../../product/screens/qrcode_page.dart';
import '../../product/services/product_serviecs.dart';
import '../../product/widgets/customListitle.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/loader.dart';
import '../../widgets/single_product.dart';

class QRCodeResultScreen extends StatefulWidget {
  String id;
  QRCodeResultScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<QRCodeResultScreen> createState() => _QRCodeResultScreenState();
}

class _QRCodeResultScreenState extends State<QRCodeResultScreen> {
  final ProductServices productServices = ProductServices();
  final ProcessServices processServices = ProcessServices();
  int selectedImage = 0;
  bool isSeeAll = false;
  void isSeeAllCheck() {
    setState(() {
      isSeeAll = true;
    });
  }

  bool shouldReload = false;

  String processID = "";
  String userID = "";
  Product? product;
  Future fetchProduct() async {
    // tracking = await
    product = await productServices.fetchDetailProducts(
        context: context, id: widget.id);
    if (mounted) {
      setState(() {
        processID = product?.processId ?? '';
        userID = product?.userId ?? '';
        fetchProcess();
        fetchName();
      });
    }
    // print(product);
  }

  bool isLoading = true;
  List<Tracking> tracking = [];
  Future fetchTracking() async {
    // tracking = await
    tracking =
        await productServices.fetchAllTracking(context: context, id: widget.id);
    if (mounted) {
      setState(() {
        results = tracking;
      });
    }
    // print(product);
  }

  List<Tracking> results = [];
  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = tracking;
    } else {
      setState(() {
        results = tracking
            .where((user) =>
                user.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
            .toList();
      });
      // we use the toLowerCase() method to make it case-insensitive
    } // Refresh the UI
  }

  String nameUser = "";
  Future fetchName() async {
    nameUser =
        await productServices.fetchNameUser(context: context, userId: userID);
    if (mounted) {
      setState(() {
        // Cập nhật trạng thái của widget chỉ khi widget vẫn còn mounted
      });
    }
  }

  String? stagePlantCare = "";
  String? stageBloom = "";
  String? stageHarvest = "";
  String? stageSell = "";
  String? stagePlantSeed = "";
  String? stageCover = "";
  Process? process;
  Future fetchProcess() async {
    process = await processServices.fetchAllProcessTitle(
        context: context, id: processID);
    if (mounted) {
      setState(() {
        stageBloom = process?.stageBloom?.name ?? '';
        stagePlantCare = process?.stagePlantCare?.name ?? '';
        stageHarvest = process?.stageHarvest?.name ?? '';
        stageSell = process?.stageSell?.name ?? '';
        stagePlantSeed = process?.stagePlantSeeds?.name ?? '';
        stageCover = process?.stageCover?.name ?? '';
      });
    }
    // print(process!.stageBloom!.name);
  }

  _launchURL() async {
    String url = product!.url;
    var urllaunchable =
        await canLaunch(url); //canLaunch is from url_launcher package
    if (urllaunchable) {
      await launch(url); //launch is from url_launcher package to launch URL
    } else {
      print("URL can't be launched.");
      ;
    }
  }

  void initState() {
    // TODO: implement initState
    setState(() {
      shouldReload = true;
    });
    super.initState();
    fetchProduct();
    fetchTracking();
    // fetchName();
    // fetchProcess();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    var size = MediaQuery.of(context).size;
    // if (shouldReload) {
    //   fetchProduct();
    // }
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : Scaffold(
                backgroundColor: Colors.white,
                body: Visibility(
                  visible: isLoading,
                  child: RefreshIndicator(
                    onRefresh: fetchTracking,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: size.height * 0.35,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                SizedBox(
                                  child: Swiper(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return FancyShimmerImage(
                                        width: double.infinity,
                                        imageUrl:
                                            product!.images[index].toString(),
                                        boxFit: BoxFit.scaleDown,
                                      );
                                    },
                                    autoplay: true,
                                    itemCount: product!.images.length,
                                    pagination: const SwiperPagination(
                                      alignment: Alignment.bottomCenter,
                                      builder: DotSwiperPaginationBuilder(
                                        color: Colors.white,
                                        activeColor: Colors.red,
                                      ),
                                    ),
                                    // control: const SwiperControl(),
                                  ),
                                ),
                                Positioned(
                                    top: 60,
                                    left: 20,
                                    right: 30,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: Color.fromARGB(
                                                        255, 28, 19, 19)
                                                    .withOpacity(.15)),
                                            child: Icon(Icons.arrow_back,
                                                color: Color.fromARGB(
                                                        255, 9, 225, 99)
                                                    .withOpacity(.8)),
                                          ),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          RefreshIndicator(
                            onRefresh: fetchProduct,
                            child: TopRoundedContainer(
                              color: ColorPalette.primaryColor,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        child: Container(
                                          width: 150,
                                          height: 7,
                                          decoration: BoxDecoration(
                                              color: ColorPalette.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 250,
                                                height: 80,
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    product!.name,
                                                    textAlign: TextAlign.left,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                width: 290,
                                                height: 60,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                            Icons.add_location),
                                                        Container(
                                                          width: 250,
                                                          child: Text(
                                                            product!.address,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons
                                                            .calendar_today_outlined),
                                                        Container(
                                                          width: 250,
                                                          child: Text(
                                                            product!.time,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  color:
                                                      ColorPalette.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  )),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              QRCodePage(
                                                                id: product!
                                                                    .productId,
                                                              )));
                                                },
                                                child: QrImageView(
                                                  data: product!.productId,
                                                  version: QrVersions.auto,
                                                  size: 70.0,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                      Align(
                                        child: Container(
                                          width: 500,
                                          height: 0.5,
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 214, 216, 212),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.account_circle_outlined,
                                                  size: 30,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  nameUser,
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                )
                                              ],
                                            ),
                                            // ButtonWidget(title: "Check", onTap: _launchURL),
                                            RichText(
                                                text: TextSpan(
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = _launchURL,
                                                    text: "Kiểm tra",
                                                    style: TextStyle(
                                                        color: ColorPalette
                                                            .primaryColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w800))),
                                          ]),
                                      SizedBox(height: 20),
                                      Align(
                                        child: Container(
                                          width: 500,
                                          height: 0.5,
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 214, 216, 212),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Mô tả ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailDescription(
                                                            product: product!,
                                                          )));
                                            },
                                            child: Text(
                                              "Xem thêm",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  decorationColor:
                                                      Colors.amber),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        product!.description,
                                        maxLines: isSeeAll == false
                                            ? 3
                                            : product!.description.length,
                                      ),
                                      SizedBox(height: 20),
                                      Align(
                                        child: Container(
                                          width: 500,
                                          height: 0.5,
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 214, 216, 212),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Nhật ký : ${tracking.length}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          user.userType == "Nông dân"
                                              ? ButtonWidget(
                                                  title: "Thêm",
                                                  onTap: () => {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AddTrackingScreen(
                                                                  product:
                                                                      product!,
                                                                )))
                                                  },
                                                )
                                              : Container()
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      TextField(
                                        onChanged: (value) {
                                          value = value.toLowerCase();
                                          setState(() {
                                            results = tracking
                                                .where((user) => user.name
                                                    .toLowerCase()
                                                    .contains(
                                                        value.toLowerCase()))
                                                .toList();
                                          });
                                        },
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 15,
                                                    horizontal: 15),
                                            hintText: "Tên theo dõi",
                                            suffixIcon: Icon(Icons.search),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(),
                                            )),
                                      ),
                                      SizedBox(height: 5),
                                      Expanded(
                                        flex: 8,
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 255, 252, 252),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      kMediumPadding))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                tracking!.isEmpty &&
                                                        process == null
                                                    ? GestureDetector(
                                                        child: Text("Trống"))
                                                    : Expanded(
                                                        child: ListView.builder(
                                                          itemCount:
                                                              results!.length,
                                                          itemBuilder: (context,
                                                                  index) =>
                                                              customListTile(
                                                                  results![
                                                                      index],
                                                                  product!,
                                                                  process!,
                                                                  context),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
  }

  GestureDetector buildSmallPreview(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: selectedImage == index
                    ? ColorPalette.primaryColor
                    : Colors.transparent)),
        child: SingleProduct(image: product!.images[index], height: 10),
      ),
    );
  }
}

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);
  final Color color;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 10),
        width: double.infinity,
        height: size.height,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: child,
      ),
    );
  }
}
