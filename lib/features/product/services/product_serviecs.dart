import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../models/product.dart';
import '../../../models/tracking.dart';
import '../../../models/user.dart';
import '../../../providers/user_providers.dart';
import '../../../utils/constans.dart';
import '../../../utils/utils.dart';
import '../screens/product_screen.dart';

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
          id: '',
          name: name,
          address: address,
          time: time,
          description: description,
          images: imageUrls,
          tracking: []);
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

  void updateProduct(
      {required BuildContext context,
      required String id,
      required String name,
      required String address,
      required String time,
      required String description,
      required List<String> images}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      // final cloudinary = CloudinaryPublic('ds6usv4r6', 'iwveqhbf');
      // List<String> imageUrls = [];
      // for (int i = 0; i < images.length; i++) {
      //   CloudinaryResponse res = await cloudinary.uploadFile(
      //     CloudinaryFile.fromFile(images[i].path, folder: name),
      //   );
      //   imageUrls.add(res.secureUrl);
      // }
      Product product = Product(
          id: '',
          name: name,
          address: address,
          time: time,
          description: description,
          images: images,
          tracking: []);
      http.Response res = await http.put(
          Uri.parse('${Constants.uri}/product/update-product/$id'),
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
            showSnackBar(context, 'Update product successfully');
            Navigator.of(context).pushNamed(
              ProductScreen.routeName,
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void deleteProduct({
    required BuildContext context,
    required String id,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse('${Constants.uri}/product/delete-product/${id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Delete product successfully');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void addTracking(
      {required BuildContext context,
      required String id,
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
      Tracking tracking = Tracking(
          id: '',
          name: name,
          address: address,
          time: time,
          description: description,
          images: imageUrls);
      http.Response res = await http.post(
          Uri.parse('${Constants.uri}/tracking/add-tracking/$id'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: tracking.toJson());
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Tracking added successfully');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all the products
  Future<List<Product>> fetchAllProducts(
      {required BuildContext context}) async {
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
          final json = jsonDecode(res.body);
          final result = json["data"];
          // print(json["data"]["products"]);
          for (int i = 0; i < result.length; i++) {
            if (result[i]["userId"] == userProvider.user.id)
              productList.add(Product.fromJson(jsonEncode(result[i])));
          }
          // for (int i = 0; i < productList.length; i++) {
          //   print(productList[i].name);
          // }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  //Recommended product list
  Future<List<Product>> fetchProducts({required BuildContext context}) async {
    List<Product> productAll = [];
    try {
      http.Response res = await http
          .get(Uri.parse('${Constants.uri}/product/get-product'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final json = jsonDecode(res.body);
          final item = json["data"];
          // print(item);
          // print(json["data"]["products"]);
          for (int i = 0; i < item.length; i++) {
            productAll.add(Product.fromJson(jsonEncode(item[i])));
          }
          print(productAll);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productAll;
  }

  Future<List<Product>> fetchDetailProducts(
      {required BuildContext context, required String id}) async {
    List<Product> productAll = [];
    try {
      http.Response res = await http
          .get(Uri.parse('${Constants.uri}/product/get-product/$id'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final json = jsonDecode(res.body);
          final item = json["data"];
          // print(item);
          // print(json["data"]["products"]);
          for (int i = 0; i < item.length; i++) {
            productAll.add(Product.fromJson(jsonEncode(item[i])));
          }
          print(productAll);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productAll;
  }

  Future<List<Tracking>> fetchAllTracking(
      {required BuildContext context, required String id}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Tracking> trackingList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('${Constants.uri}/product/get-product/$id'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final json = jsonDecode(res.body);
          // name = json["data"]["tracking"];
          // print(json["data"]["tracking"]);
          final result = json["data"]["tracking"];
          // print(json["data"]["tracking"]);
          for (int i = 0; i < result.length; i++) {
            trackingList.add(Tracking.fromJson(jsonEncode(result[i])));
          }
          // print("TrackingList: ");
          // print(trackingList);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    // return trackingList;
    return trackingList;
  }
}
