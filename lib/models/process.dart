import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// class Process {
//   final String id;
//   final String name;
//   final String time;
//   final String description;
//   final List<String> images;
//   Process({
//     required this.id,
//     required this.name,
//     required this.time,
//     required this.description,
//     required this.images,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//       'time': time,
//       'images': images,
//     };
//   }

//   factory Process.fromMap(Map<String, dynamic> map) {
//     return Process(
//         id: map['_id'] as String,
//         name: map['name'] as String,
//         time: map['time'] as String,
//         description: map['description'] as String,
//         images: List<String>.from(
//           (map['images'] as List<dynamic>),
//         ));
//   }

//   String toJson() => json.encode(toMap());

//   factory Process.fromJson(String source) =>
//       Process.fromMap(json.decode(source) as Map<String, dynamic>);
// }

class Process {
  StageProcess? stageProcess;
  StagePlantSeeds? stagePlantSeeds;
  StagePlantCare? stagePlantCare;
  StagePlantSeeds? stageBloom;
  StagePlantSeeds? stageCover;
  StageHarvest? stageHarvest;
  StageSell? stageSell;
  String? sId;

  Process({
    this.stageProcess,
    this.stagePlantSeeds,
    this.stagePlantCare,
    this.stageBloom,
    this.stageCover,
    this.stageHarvest,
    this.stageSell,
    this.sId,
  });

  Process.fromJson(Map<String, dynamic> json) {
    stageProcess = json['stageProcess'] != null
        ? new StageProcess.fromJson(json['stageProcess'])
        : null;
    stagePlantSeeds = json['stagePlantSeeds'] != null
        ? new StagePlantSeeds.fromJson(json['stagePlantSeeds'])
        : null;
    stagePlantCare = json['stagePlantCare'] != null
        ? new StagePlantCare.fromJson(json['stagePlantCare'])
        : null;
    stageBloom = json['stageBloom'] != null
        ? new StagePlantSeeds.fromJson(json['stageBloom'])
        : null;
    stageCover = json['stageCover'] != null
        ? new StagePlantSeeds.fromJson(json['stageCover'])
        : null;
    stageHarvest = json['stageHarvest'] != null
        ? new StageHarvest.fromJson(json['stageHarvest'])
        : null;
    stageSell = json['stageSell'] != null
        ? new StageSell.fromJson(json['stageSell'])
        : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stageProcess != null) {
      data['stageProcess'] = this.stageProcess!.toJson();
    }
    if (this.stagePlantSeeds != null) {
      data['stagePlantSeeds'] = this.stagePlantSeeds!.toJson();
    }
    if (this.stagePlantCare != null) {
      data['stagePlantCare'] = this.stagePlantCare!.toJson();
    }
    if (this.stageBloom != null) {
      data['stageBloom'] = this.stageBloom!.toJson();
    }
    if (this.stageCover != null) {
      data['stageCover'] = this.stageCover!.toJson();
    }
    if (this.stageHarvest != null) {
      data['stageHarvest'] = this.stageHarvest!.toJson();
    }
    if (this.stageSell != null) {
      data['stageSell'] = this.stageSell!.toJson();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class StageProcess {
  String? name;
  List<String>? images;
  String? timeCreate;
  String? description;

  StageProcess({this.name, this.images, this.timeCreate, this.description});

  StageProcess.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    images = json['images'].cast<String>();
    timeCreate = json['timeCreate'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['images'] = this.images;
    data['timeCreate'] = this.timeCreate;
    data['description'] = this.description;
    return data;
  }
}

class StagePlantSeeds {
  String? name;
  String? description;

  StagePlantSeeds({this.name, this.description});

  StagePlantSeeds.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}

class StagePlantCare {
  String? name;
  String? description;
  String? water;
  String? fertilizer;

  StagePlantCare({this.name, this.description, this.water, this.fertilizer});

  StagePlantCare.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    water = json['water'];
    fertilizer = json['fertilizer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['water'] = this.water;
    data['fertilizer'] = this.fertilizer;
    return data;
  }
}

class StageHarvest {
  String? name;
  String? description;
  String? quantity;

  StageHarvest({this.name, this.description, this.quantity});

  StageHarvest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    return data;
  }
}

class StageSell {
  String? name;
  String? description;
  String? purchasingUnit;

  StageSell({this.name, this.description, this.purchasingUnit});

  StageSell.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    purchasingUnit = json['purchasingUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['purchasingUnit'] = this.purchasingUnit;
    return data;
  }
}
