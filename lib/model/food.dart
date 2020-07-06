class Food {
  String id;
  String name;
  String description;
  Food.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    description = data['description'];
  }
}
