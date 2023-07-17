// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/constants/color_constants.dart';
import 'package:mobile_app_blockchain/core/helpers/assets_helper.dart';
import 'package:mobile_app_blockchain/core/helpers/image_helper.dart';
import 'package:mobile_app_blockchain/features/product/screens/add_tracking_screen.dart';
import 'package:mobile_app_blockchain/features/product/screens/description_detail.dart';
import 'package:mobile_app_blockchain/features/product/screens/qrcode_page.dart';
import 'package:mobile_app_blockchain/features/product/screens/tracking_detail.dart';
import 'package:mobile_app_blockchain/features/product/widgets/customListitle.dart';
import 'package:mobile_app_blockchain/features/widgets/button_widgets.dart';
import 'package:mobile_app_blockchain/features/widgets/single_product.dart';
import 'package:mobile_app_blockchain/models/tracking.dart';
import 'package:mobile_app_blockchain/models/user.dart';
import 'package:mobile_app_blockchain/utils/constans.dart';
import 'package:mobile_app_blockchain/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/dismenssion_constants.dart';
import '../../../models/process.dart';
import '../../../models/product.dart';
import '../../../providers/user_providers.dart';
import '../../newfeed/services/process_services.dart';
import '../../widgets/loader.dart';
import '../services/product_serviecs.dart';
import '../widgets/custom_app_bar.dart';

class DeatilProductScreen extends StatefulWidget {
  Product product;
  DeatilProductScreen({
    Key? key,
    required this.product,
  }) : super(key: key);
  @override
  State<DeatilProductScreen> createState() => _DeatilProductScreenState();
}

class _DeatilProductScreenState extends State<DeatilProductScreen> {
  final ProductServices productServices = ProductServices();
  final ProcessServices processServices = ProcessServices();
  int selectedImage = 0;
  bool isSeeAll = false;
  bool shouldReload = false;
  void isSeeAllCheck() {
    setState(() {
      isSeeAll = true;
    });
  }

  bool isLoading = true;
  List<Tracking> tracking = [];
  Future fetchTracking() async {
    tracking = await productServices.fetchAllTracking(
        context: context, id: widget.product.productId);
    if (mounted) {
      setState(() {
        results = tracking;
        if (tracking.length > 0) {
          fetchDetailProduct();
        }
      });
    }
  }

  int? productNumber = 0;
  Future fetchDetailProduct() async {
    productNumber = await productServices.fetchDetailProductsBC(
        context: context, id: widget.product.productId);
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
        context: context, id: widget.product.processId);
    if (mounted) {
      setState(() {
        stageBloom = process!.stageBloom!.name;
        stagePlantCare = process!.stagePlantCare!.name;
        stageHarvest = process!.stageHarvest!.name;
        stageSell = process!.stageSell!.name;
        stagePlantSeed = process!.stagePlantSeeds!.name;
        stageCover = process!.stageCover!.name;
      });
    }

    // print(process!.stageBloom!.name);
  }

  List<String?> nameStage() {
    return [
      stagePlantSeed,
      stagePlantCare,
      stageBloom,
      stageCover,
      stageHarvest,
      stageSell
    ];
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTracking();
    fetchDetailProduct();
    fetchProcess();
    print(process);
    setState(() {
      shouldReload = true;
    });
    // fetchProduct();

    // foundtracking = tracking;
  }

  _launchURL() async {
    String url = widget.product.url;
    var urllaunchable =
        await canLaunch(url); //canLaunch is from url_launcher package
    if (urllaunchable) {
      await launch(url,
          forceWebView: true,
          enableJavaScript:
              true); //launch is from url_launcher package to launch URL
    } else {
      print("URL can't be launched.");
      ;
      showSnackBar(context, "URL can't be launched");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    var size = MediaQuery.of(context).size;
    // if (shouldReload) {
    //   fetchTracking();
    // }
    return Scaffold(
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
                          itemBuilder: (BuildContext context, int index) {
                            return FancyShimmerImage(
                              width: double.infinity,
                              imageUrl:
                                  widget.product!.images![index].toString(),
                              boxFit: BoxFit.scaleDown,
                            );
                          },
                          autoplay: true,
                          itemCount: widget.product!.images!.length,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Color.fromARGB(255, 28, 19, 19)
                                          .withOpacity(.15)),
                                  child: Icon(Icons.arrow_back,
                                      color: Color.fromARGB(255, 9, 225, 99)
                                          .withOpacity(.8)),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                TopRoundedContainer(
                  color: ColorPalette.primaryColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            child: Container(
                              width: 150,
                              height: 7,
                              decoration: BoxDecoration(
                                  color: ColorPalette.primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 250,
                                    height: 80,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.product.name,
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
                                    child: Row(
                                      children: [
                                        Icon(Icons.add_location),
                                        Container(
                                          width: 250,
                                          child: Text(
                                            widget.product.address,
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
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
                                      color: ColorPalette.primaryColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      )),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => QRCodePage(
                                                    id: widget.product.id,
                                                  )));
                                    },
                                    child: QrImageView(
                                      data: widget.product.productId,
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
                                  color: Color.fromARGB(255, 214, 216, 212),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    user.name,
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                              // ButtonWidget(title: "Check", onTap: _launchURL),
                              RichText(
                                  text: TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = _launchURL,
                                      text: "Kiểm tra",
                                      style: TextStyle(
                                          color: ColorPalette.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800))),
                            ],
                          ),
                          SizedBox(height: 20),
                          Align(
                            child: Container(
                              width: 500,
                              height: 0.5,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 214, 216, 212),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Mô tả sản phẩm ",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailDescription(
                                                product: widget.product,
                                              )));
                                },
                                child: Text(
                                  "Xem thêm",
                                  style: TextStyle(
                                      fontSize: 15,
                                      decorationColor: Colors.amber),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(
                            widget.product.description,
                            maxLines: isSeeAll == false
                                ? 3
                                : widget.product.description.length,
                          ),
                          SizedBox(height: 20),
                          Align(
                            child: Container(
                              width: 500,
                              height: 0.5,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 214, 216, 212),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Nhật ký : ${tracking.length}",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              user.userType == "Farmer" && productNumber != 3
                                  ? ButtonWidget(
                                      title: "Thêm",
                                      onTap: () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddTrackingScreen(
                                                      product: widget.product,
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
                                        .contains(value.toLowerCase()))
                                    .toList();
                              });
                            },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                hintText: "Tên theo dõi",
                                suffixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(),
                                )),
                          ),
                          SizedBox(height: 5),
                          Expanded(
                            flex: 8,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 252, 252),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(kMediumPadding))),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    tracking!.isEmpty && process == null
                                        ? Text("Trống")
                                        : Expanded(
                                            child: ListView.builder(
                                              itemCount: results!.length,
                                              itemBuilder: (context, index) =>
                                                  customListTile(
                                                      results![index],
                                                      widget.product,
                                                      process,
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
        child: SingleProduct(image: widget.product.images[index], height: 10),
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
