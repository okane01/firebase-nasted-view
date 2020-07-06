class Zillas {
  String id;
  String name;
  String imageUrl;
  List categories;
  String description;
  Zillas({
    this.id,
    this.name,
    this.imageUrl,
    this.categories,
    this.description,
  });
  Zillas.fromMap(Map<String, dynamic> zilla) {
    id = zilla['id'];
    name = zilla['name'];
    imageUrl = zilla['imageUrl'];
    categories = zilla['categories'];
    description = zilla['description'];
  }
}
