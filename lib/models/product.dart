import 'dart:convert';

import 'package:mobile_app_blockchain/models/tracking.dart';

import '../../../models/user.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String id;
  final String name;
  final String address;
  final String time;
  final String description;
  final List<String> images;
  final List<Tracking> tracking;
  Product({
    required this.id,
    required this.name,
    required this.address,
    required this.time,
    required this.description,
    required this.images,
    required this.tracking,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'time': time,
      'description': description,
      'images': images,
      'tracking': tracking.map((track) => track.toMap()).toList()
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    final id = map['_id'] as String;
    final name = map['name'] as String;
    final address = map['address'] as String;
    final time = map['time'] as String;
    final description = map['description'] as String;
    final images = List<String>.from(
      (map['images'] as List<dynamic>),
    );
    final trackingData = map['tracking'] as List<dynamic>?;
    final tracking = trackingData != null
        ? trackingData
            .map((trackingData) => Tracking.fromMap(trackingData))
            .toList()
        : <Tracking>[];
    return Product(
        id: id,
        name: name,
        address: address,
        time: time,
        description: description,
        images: images,
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
    String? description,
    List<String>? images,
    List<Tracking>? tracking,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      time: time ?? this.time,
      description: description ?? this.description,
      images: images ?? this.images,
      tracking: tracking ?? this.tracking,
    );
  }
}
