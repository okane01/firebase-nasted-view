class Division {
  String id;
  String name;
  String imageUrl;
  String description; 
  Division.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    imageUrl = data['imageUrl'];
    description = data['description'];
  }
}
