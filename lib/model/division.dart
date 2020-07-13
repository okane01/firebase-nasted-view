class Division {
  String id;
  String name;
  String imageUrl;
  List categories;
  String description;
  Division.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    imageUrl = data['imageUrl'];
    categories = data['categories'];
    description = data['description'];
  }
}
