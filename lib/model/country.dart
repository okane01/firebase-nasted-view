import 'package:cloud_firestore/cloud_firestore.dart';

class Country {
  String id;
  String name;
  String divid;
  String imageUrl;
  List subPlaces;
  String description;
  Timestamp createdAt;
  Timestamp updatedAt;
  Country();
  Country.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    divid = data['divid'];
    imageUrl = data['imageUrl'];
    subPlaces = data['subPlaces'];
    description = data['description'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'divid': divid,
      'imageUrl': imageUrl,
      'subPlaces': subPlaces,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
