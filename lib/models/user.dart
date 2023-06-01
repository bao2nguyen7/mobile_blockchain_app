import 'dart:convert';

import 'package:mobile_app_blockchain/models/product.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String userType;
  final String token;
  final List<String> products;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.token,
    required this.userType,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'userType': userType,
      'token': token,
      'products': products
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    final id = map['_id'] as String;
    final name = map['name'] as String;
    final email = map['email'] as String;
    final password = map['password'] as String;
    final token = map['token'] as String;
    final userType = map['userType'] as String;
    final products = List<String>.from((map['products'] as List<dynamic>));
    // final productsData = map['products'] as List<String>;
    // final products = productsData != null
    //     ? productsData
    //         .map((productData) => Product.fromMap(productData["id"))
    //         .toList()
    //     : <Product>[];
    return User(
        id: id,
        name: name,
        email: email,
        password: password,
        userType: userType,
        token: token,
        products: products);
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? userType,
    String? token,
    List<String>? products,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      userType: userType ?? this.userType,
      token: token ?? this.token,
      products: products ?? this.products,
    );
  }
}
