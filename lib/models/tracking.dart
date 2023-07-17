import 'dart:convert';

import '../../../models/user.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Tracking {
  final String id;
  final String name;
  final String time;
  final String url;
  final String productId;
  final String trackingId;
  final String description;
  final List<String> images;
  final List<String> notes;
  Tracking({
    required this.id,
    required this.name,
    required this.time,
    required this.url,
    required this.productId,
    required this.trackingId,
    required this.description,
    required this.images,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'time': time,
      'url': url,
      'productId': productId,
      'trackingId': trackingId,
      'description': description,
      'images': images,
      'notes': notes,
    };
  }

  factory Tracking.fromMap(Map<String, dynamic> map) {
    return Tracking(
        id: map['_id'] as String,
        name: map['name'] as String,
        time: map['time'] as String,
        url: map['url'] as String,
        productId: map['productId'] as String,
        trackingId: map['trackingId'] as String,
        description: map['description'] as String,
        notes: List<String>.from(map['notes'] as List<dynamic>),
        images: List<String>.from(
          (map['images'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory Tracking.fromJson(String source) =>
      Tracking.fromMap(json.decode(source) as Map<String, dynamic>);
}
