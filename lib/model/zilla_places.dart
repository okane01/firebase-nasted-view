import 'package:cloud_firestore/cloud_firestore.dart';

class ZillaPlaces {
  String id;
  String name;
  String imageUrl;
  String divid;
  List categories;
  String description;
  Timestamp createdAt;
  Timestamp updatedAt;
  ZillaPlaces({this.id, this.name, this.imageUrl, this.divid, this.categories,
      this.description, this.createdAt, this.updatedAt});
  ZillaPlaces.fromMap(Map<String, dynamic> zilla) {
    id = zilla['id'];
    name = zilla['name'];
    imageUrl = zilla['imageUrl'];
    categories = zilla['categories'];
    description = zilla['description'];
    createdAt = zilla['createdAt'];
    updatedAt = zilla['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'divid': divid,
      'imageUrl': imageUrl,
      'categories': categories,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
