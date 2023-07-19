// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/helpers/assets_helper.dart';
import 'package:mobile_app_blockchain/core/helpers/image_helper.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  final double height;
  const SingleProduct({
    Key? key,
    required this.image,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noImage = ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: ImageHelper.loadFromAsset(
        AssetsHelper.loadImage,
        height: 120,
        width: 200,
      ),
    );
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Container(
            width: 170,
            // padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      image,
                      loadingBuilder: (context, child, loadingProgress) =>
                          (loadingProgress == null)
                              ? child
                              : CircularProgressIndicator(),
                      errorBuilder: (context, error, stackTrace) => noImage,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: height,
                    ),
                  )
                : noImage),
      ),
    );
  }
}
