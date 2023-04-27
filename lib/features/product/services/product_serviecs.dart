import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../models/product.dart';
import '../../../models/user.dart';
import '../../../providers/user_providers.dart';
import '../../../utils/constans.dart';
import '../../../utils/utils.dart';

class ProductServices {
  void addProduct(
      {required BuildContext context,
      required String name,
      required String address,
      required String time,
      required String description,
      required List<File> images}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('ds6usv4r6', 'iwveqhbf');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(
          name: name,
          address: address,
          time: time,
          description: description,
          images: imageUrls);
      http.Response res =
          await http.post(Uri.parse('${Constants.uri}/product/add-product'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: product.toJson());
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user
                .copyWith(products: jsonDecode(res.body)['products']);
            userProvider.setUserFromModel(user);
            showSnackBar(context, 'Product added successfully');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all the products
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('${Constants.uri}/product/get-product'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}
