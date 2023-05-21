import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Process {
  final String id;
  final String name;
  final String time;
  final String description;
  final List<String> images;
  Process({
    required this.id,
    required this.name,
    required this.time,
    required this.description,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'time': time,
      'images': images,
    };
  }

  factory Process.fromMap(Map<String, dynamic> map) {
    return Process(
        id: map['_id'] as String,
        name: map['name'] as String,
        time: map['time'] as String,
        description: map['description'] as String,
        images: List<String>.from(
          (map['images'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory Process.fromJson(String source) =>
      Process.fromMap(json.decode(source) as Map<String, dynamic>);
}
