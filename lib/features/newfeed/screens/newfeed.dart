import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/features/newfeed/services/process_services.dart';
import 'package:mobile_app_blockchain/features/newfeed/widget/customListitle.dart';
import 'package:mobile_app_blockchain/utils/constans.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/dismenssion_constants.dart';
import '../../../models/process.dart';
import '../../../providers/user_providers.dart';
import '../../home/screens/main_app_screen.dart';
import '../../user/home_user/screens/main_app_screen.dart';
import '../../widgets/loader.dart';
import '../../widgets/single_product.dart';

class NewFeedScreen extends StatefulWidget {
  const NewFeedScreen({super.key});
  static const String routeName = '/new_feed_screen';
  @override
  State<NewFeedScreen> createState() => _NewFeedScreenState();
}

class _NewFeedScreenState extends State<NewFeedScreen> {
  final ProcessServices processServices = ProcessServices();
  void initState() {
    super.initState();
    fetchProcess();
  }

  bool isLoading = true;
  List<Process>? process;
  Future fetchProcess() async {
    process = await processServices.fetchAllProcess(context: context);
    if (mounted) {
      setState(() {});
    }
    // print(product);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 20,
        title: Text(
          "Bảng tin",
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
                        child: process == null
                            ? Loader()
                            : Visibility(
                                visible: isLoading,
                                child: RefreshIndicator(
                                  onRefresh: fetchProcess,
                                  child: ListView.builder(
                                      itemCount: process!.length,
                                      itemBuilder: (context, index) =>
                                          customListTile(
                                              process![index], context)),
                                )),
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}
