import 'dart:collection';

import 'package:firedemo1/model/division.dart';
import 'package:firedemo1/model/zilla.dart';
import 'package:flutter/foundation.dart';

class FoodNotifier with ChangeNotifier {
  List<Division> _items = [];
  Division _currentDivision;
  UnmodifiableListView<Division> get items => UnmodifiableListView(_items);
  Division get currentDivision => _currentDivision;

  set items(List<Division> division) {
    _items = division;
    notifyListeners();
  }

  set currentDivision(Division division) {
    _currentDivision = division;
    notifyListeners();
  }

  List<Zillas> _zilla = [];
  Zillas _currentZilla;
  List<Zillas> get zilla => [..._zilla];
  Zillas get currentZilla => _currentZilla;

  set zilla(List<Zillas> zilla) {
    _zilla = zilla;
    notifyListeners();
  }

  set currentZilla(Zillas zilla) {
    _currentZilla = zilla;
    notifyListeners();
  }

  // List<ZillaPlaces> _zillaPlaces = [];

  // List<ZillaPlaces> get zillaPlaces => [..._zillaPlaces];

  // set zillaPlaces(List<ZillaPlaces> zilla) {
  //   _zillaPlaces = zilla;
  //   notifyListeners();
  // }
}
