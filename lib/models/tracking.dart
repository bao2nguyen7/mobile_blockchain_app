import 'dart:convert';

import '../../../models/user.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Tracking {
  final String id;
  final String name;
  final String time;
  final String url;
  final String description;
  final List<String> images;
  Tracking({
    required this.id,
    required this.name,
    required this.time,
    required this.url,
    required this.description,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'time': time,
      'url': url,
      'description': description,
      'images': images,
    };
  }

  factory Tracking.fromMap(Map<String, dynamic> map) {
    return Tracking(
        id: map['_id'] as String,
        name: map['name'] as String,
        time: map['time'] as String,
        url: map['url'] as String,
        description: map['description'] as String,
        images: List<String>.from(
          (map['images'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory Tracking.fromJson(String source) =>
      Tracking.fromMap(json.decode(source) as Map<String, dynamic>);
}
