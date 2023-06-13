import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductSC {
  final String pid;
  final String uid;
  final String name;
  final String address;
  final int status;
  ProductSC({
    required this.pid,
    required this.uid,
    required this.name,
    required this.address,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'uid': uid,
      'name': name,
      'address': address,
      'status': status,
    };
  }

  factory ProductSC.fromMap(Map<String, dynamic> map) {
    return ProductSC(
      pid: map['pid'] as String,
      uid: map['uid'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      status: map['status'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductSC.fromJson(String source) =>
      ProductSC.fromMap(json.decode(source) as Map<String, dynamic>);
}
