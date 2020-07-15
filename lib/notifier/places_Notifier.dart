import 'dart:collection';
import 'package:firedemo1/model/division.dart';
import 'package:firedemo1/model/zilla.dart';
import 'package:firedemo1/model/zilla_places.dart';
import 'package:flutter/foundation.dart';

import '../model/country.dart';

class AllPlacesNotifier with ChangeNotifier {
  List<Country> _countryList = [];
  Country _currentCountry;

  UnmodifiableListView<Country> get countryList =>
      UnmodifiableListView(_countryList);

  Country get currentCountry => _currentCountry;

  set countryList(List<Country> country) {
    _countryList = country;
    notifyListeners();
  }

  set currentCountry(Country country) {
    _currentCountry = country;
    notifyListeners();
  }

  List<Division> _divisionList = [];
  Division _currentDivision;

  UnmodifiableListView<Division> get divisionList =>
      UnmodifiableListView(_divisionList);

  Division get currentDivision => _currentDivision;

  set divisionList(List<Division> division) {
    _divisionList = division;
    notifyListeners();
  }

  set currentDivision(Division division) {
    currentDivision = division;
    notifyListeners();
  }

  List<Zilla> _zilla = [];
  Zilla _currentZilla;
  List<Zilla> get zilla => [..._zilla];
  Zilla get currentZilla => _currentZilla;

  set zilla(List<Zilla> zilla) {
    _zilla = zilla;
    notifyListeners();
  }

  set currentZilla(Zilla zilla) {
    _currentZilla = zilla;
    notifyListeners();
  }

  List<ZillaPlaces> _zillaPlaces = [];
  ZillaPlaces _currentZillaPlaces;
  List<ZillaPlaces> get zillaPlaces => [..._zillaPlaces];
  ZillaPlaces get currentZillaPlaces => _currentZillaPlaces;

  set zillaPlaces(List<ZillaPlaces> zilla) {
    _zillaPlaces = zilla;
    notifyListeners();
  }

  set currentZillaPlaces(ZillaPlaces zilla) {
    _currentZillaPlaces = zilla;
    notifyListeners();
  }
}
