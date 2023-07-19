import 'dart:convert';

import 'package:mobile_app_blockchain/models/tracking.dart';

import '../../../models/user.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String id;
  final String name;
  final String address;
  final String time;
  final String url;
  final String productId;
  final String description;
  final String processId;
  final String userId;
  final List<String> images;
  final List<String> certificates;
  final List<String> tracking;
  Product({
    required this.id,
    required this.name,
    required this.address,
    required this.time,
    required this.url,
    required this.productId,
    required this.description,
    required this.processId,
    required this.images,
    required this.userId,
    required this.certificates,
    required this.tracking,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'time': time,
      'processId': processId,
      'productId': productId,
      'description': description,
      'images': images,
      'certificates': certificates,
      'url': url,
      'userId': userId,
      'tracking': tracking
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    final id = map['_id'] as String;
    final name = map['name'] as String;
    final address = map['address'] as String;
    final time = map['time'] as String;
    final url = map['url'] as String;
    final userId = map['userId'] as String;
    final productId = map['productId'] as String;
    final processId = map['processId'] as String;
    final description = map['description'] as String;
    final images = List<String>.from(
      (map['images'] as List<dynamic>),
    );
    final certificates = List<String>.from(
      (map['certificates'] as List<dynamic>),
    );
    final tracking = List<String>.from(
      (map['tracking'] as List<dynamic>),
    );
    // final trackingData = map['tracking'] as List<dynamic>?;
    // final tracking = trackingData != null
    //     ? trackingData
    //         .map((trackingData) => Tracking.fromMap(trackingData))
    //         .toList()
    //     : <Tracking>[];
    return Product(
        id: id,
        name: name,
        address: address,
        time: time,
        url: url,
        productId: productId,
        processId: processId,
        description: description,
        images: images,
        userId: userId,
        certificates: certificates,
        tracking: tracking);
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  Product copyWith({
    String? id,
    String? name,
    String? address,
    String? time,
    String? url,
    String? userId,
    String? processId,
    String? description,
    List<String>? images,
    List<String>? certificate,
    List<String>? tracking,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      time: time ?? this.time,
      productId: productId ?? this.productId,
      description: description ?? this.description,
      images: images ?? this.images,
      certificates: certificate ?? this.certificates,
      processId: processId ?? this.processId,
      url: url ?? this.url,
      userId: userId ?? this.userId,
      tracking: tracking ?? this.tracking,
    );
  }
}
