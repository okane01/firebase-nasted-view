import 'package:cloud_firestore/cloud_firestore.dart';

class Zilla {
  String id;
  String name;
  String imageUrl;
  String divid;
  List categories;
  String description;
  Timestamp updatedAt;
  Timestamp createdAt;
  Zilla({
    this.id,
    this.name,
    this.imageUrl,
    this.divid,
    this.categories,
    this.description,
    this.updatedAt,
    this.createdAt,
  });
  Zilla.fromMap(Map<String, dynamic> zilla) {
    id = zilla['id'];
    name = zilla['name'];
    imageUrl = zilla['imageUrl'];
    divid = zilla['divid'];
    categories = zilla['categories'];
    description = zilla['description'];
    updatedAt = zilla['updatedAt'];
    createdAt = zilla['createdAt'];
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
