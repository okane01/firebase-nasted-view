import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firedemo1/model/division.dart';
import 'package:firedemo1/model/zilla.dart';
import '../notifier/foodNotifier.dart';

getDivision(FoodNotifier foodNotifier) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('division').getDocuments();
  List<Division> _foods = [];

  snapshot.documents.forEach((documents) {
    Division food = Division.fromMap(documents.data);
    _foods.add(food);
  });
  foodNotifier.items = _foods;
}

getZilla(List<Zillas> zillaNotify) async {
  // ekhan theke kaj korar thakte pare FoodNotify nia
  QuerySnapshot snapshot =
      await Firestore.instance.collection('zilla').getDocuments();
  List<Zillas> _zillasList = [];

  snapshot.documents.forEach((documents) {
    Zillas food = Zillas.fromMap(documents.data);
    _zillasList.add(food);
  });
  zillaNotify = _zillasList;
}
