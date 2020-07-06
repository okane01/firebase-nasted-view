class ZillaPlaces {
  String id;
  String name;
  String imageUrl;
  List categories;
  String description;
  ZillaPlaces.fromMap(Map<String, dynamic> zilla) {
    id = zilla['id'];
    name = zilla['name'];
    imageUrl = zilla['imageUrl'];
    categories = zilla['categories'];
    description = zilla['description'];
  }
}
