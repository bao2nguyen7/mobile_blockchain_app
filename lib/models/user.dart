import 'dart:convert';

import 'package:mobile_app_blockchain/models/product.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String token;
  final List<Product> products;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.token,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'token': token,
      'products': products.map((product) => product.toMap()).toList()
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    final id = map['_id'] as String;
    final name = map['name'] as String;
    final email = map['email'] as String;
    final password = map['password'] as String;
    final token = map['token'] as String;
    final productsData = map['products'] as List<dynamic>?;
    final products = productsData != null
        ? productsData
            .map((productData) => Product.fromMap(productData))
            .toList()
        : <Product>[];
    return User(
        id: id,
        name: name,
        email: email,
        password: password,
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
    String? token,
    List<Product>? products,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      products: products ?? this.products,
    );
  }
}
