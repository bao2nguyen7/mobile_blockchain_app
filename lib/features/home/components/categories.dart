import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/helpers/assets_helper.dart';
import 'package:mobile_app_blockchain/core/helpers/image_helper.dart';

import '../../../size_config.dart';
import '../../newfeed/screens/newfeed.dart';
import '../../newfeed/screens/newfeed_detail.dart';
import '../../product/screens/add_product_screen.dart';
import '../../product/screens/journal_sceen.dart';
import '../../product/screens/product_screen.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryCard(
                icon: AssetsHelper.createProduct,
                text: "Tạo sản phẩm",
                press: () {
                  Navigator.of(context).pushNamed(AddProductScreen.routeName);
                }),
            CategoryCard(
                icon: AssetsHelper.product,
                text: "Sản Phẩm",
                press: () {
                  Navigator.of(context).pushNamed(ProductScreen.routeName);
                }),
            CategoryCard(
                icon: AssetsHelper.newFeed,
                text: "Thu hoạch",
                press: () {
                  Navigator.of(context).pushNamed(JournalScreen.routeName);
                }),
          ]),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: 55,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 176, 225, 235),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ImageHelper.loadFromAsset(icon!),
            ),
            SizedBox(height: 5),
            Text(
              text!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}
