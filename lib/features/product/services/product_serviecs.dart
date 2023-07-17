import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/core/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../models/product.dart';
import '../../../models/productSC.dart';
import '../../../models/tracking.dart';
import '../../../models/user.dart';
import '../../../providers/user_providers.dart';
import '../../../utils/constans.dart';
import '../../../utils/utils.dart';
import '../../home/screens/main_app_screen.dart';
import '../screens/product_screen.dart';

class ProductServices {
  void addProduct(
      {required BuildContext context,
      required String processId,
      required String name,
      required String address,
      required String time,
      required String description,
      required List<File> images,
      required List<File> certificates}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      List<String> certificateUrls = [];
      List<String> imageUrls = [];
      final cloudinary = CloudinaryPublic('ds6usv4r6', 'iwveqhbf');
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        print(res);
        imageUrls.add(res.secureUrl);
      }
      for (int i = 0; i < certificates.length; i++) {
        CloudinaryResponse respone = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(certificates[i].path, folder: name),
        );
        print(respone);
        certificateUrls.add(respone.secureUrl);
      }

      Product product = Product(
          id: '',
          name: name,
          address: address,
          time: time,
          productId: '',
          description: description,
          images: imageUrls,
          certificates: certificateUrls,
          processId: processId,
          url: '',
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

            showSnackBar(context, 'Sản phẩm được thêm thành công');
            // Navigator.of(context).pushNamed(ProductScreen.routeName);
            Navigator.of(context).pop();
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
      required String processId,
      required String description,
      required String productId,
      required List<String> images,
      required List<String> certificate}) async {
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
          productId: productId,
          description: description,
          processId: processId,
          url: '',
          images: images,
          certificates: certificate,
          tracking: []);
      http.Response res = await http.put(
          Uri.parse('${Constants.uri}/product/update-product/$productId'),
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
            showSnackBar(context, 'Cập nhật sản phẩm thành công');
            Navigator.of(context).pop();
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
          showSnackBar(context, 'Xoá sản phẩm thành công');
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
      required String time,
      required String description,
      required List<String> notes,
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
          time: time,
          url: '',
          productId: '',
          trackingId: '',
          notes: notes,
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
            showSnackBar(context, 'Thêm theo dõi thành công');
            Navigator.of(context).pop();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void addTrackingDeliveried(
      {required BuildContext context,
      required String id,
      required String name,
      required String time,
      required String description,
      required List<String> notes,
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
          time: time,
          url: '',
          productId: '',
          trackingId: '',
          notes: notes,
          description: description,
          images: imageUrls);
      http.Response res =
          await http.post(Uri.parse('${Constants.uri}/tracking/deliveried/$id'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: tracking.toJson());
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Thêm thông tin vận chuyển thành công');
            // Navigator.pop(context);
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
          final resultSC = json["dataSC"];
          // print(json["data"]["products"]);
          for (int i = 0; i < result.length; i++) {
            for (int j = 0; j < resultSC.length; j++) {
              if (result[i]["userId"] == userProvider.user.id &&
                  result[i]["productId"] == resultSC[j]["pid"] &&
                  resultSC[j]["status"] != 3 &&
                  resultSC[j]["status"] != 2) {
                productList.add(Product.fromJson(jsonEncode(result[i])));
              }
            }
          }
          // print(productList);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<List<Product>> fetchAllProductsDelivery(
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
          final resultSC = json["dataSC"];
          // print(json["data"]["products"]);
          for (int i = 0; i < result.length; i++) {
            for (int j = 0; j < resultSC.length; j++) {
              if (result[i]["userId"] == userProvider.user.id &&
                  result[i]["productId"] == resultSC[j]["pid"] &&
                  resultSC[j]["status"] == 3) {
                productList.add(Product.fromJson(jsonEncode(result[i])));
              }
            }
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<List<Product>> fetchAllProductsUser(
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
          final resultSC = json["dataSC"];
          // print(json["data"]["products"]);
          for (int i = 0; i < result.length; i++) {
            for (int j = 0; j < resultSC.length; j++) {
              if (result[i]["productId"] == resultSC[j]["pid"] &&
                  resultSC[j]["status"] == 3) {
                productList.add(Product.fromJson(jsonEncode(result[i])));
              }
            }
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<List<ProductSC>> fetchAllProductsSC(
      {required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductSC> productList = [];
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
          final result = json["dataSC"];
          for (int i = 0; i < result.length; i++) {
            if (result[i]["uid"] == userProvider.user.id)
              productList.add(ProductSC.fromJson(jsonEncode(result[i])));
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<Product> fetchDetailProducts(
      {required BuildContext context, required String id}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product productAll = Product(
        id: '',
        name: '',
        address: '',
        time: '',
        productId: '',
        description: '',
        processId: '',
        url: '',
        images: [],
        certificates: [],
        tracking: []);
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
          final item = json["data"];
          productAll = Product.fromJson(jsonEncode(item));
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productAll;
  }

  Future<int> fetchDetailProductsBC(
      {required BuildContext context, required String id}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    int productAll = 0;
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
          final itemBC = json["dataBC"][6];
          productAll = itemBC;
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
      http.Response res = await http.get(
          Uri.parse('${Constants.uri}/tracking/get-tracking/$id'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final json = jsonDecode(res.body);
          final result = json["data"];
          for (int i = 0; i < result.length; i++) {
            if (result[i]["productId"] == id) {
              trackingList.add(Tracking.fromJson(jsonEncode(result[i])));
            }
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    // return trackingList;
    return trackingList;
  }
}
