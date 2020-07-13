import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

import '../model/country.dart';
import '../model/division.dart';
import '../model/zilla.dart';
import '../model/zilla_places.dart';
import '../notifier/places_Notifier.dart';

getCountry(AllPlacesNotifier placesNotifier) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('country').getDocuments();
  List<Country> _country = [];

  snapshot.documents.forEach((documents) {
    Country country = Country.fromMap(documents.data);
    _country.add(country);
  });
  placesNotifier.countryList = _country;
}

// ################## Getting Division Data ########################

getDivision(AllPlacesNotifier divisionNotify) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('division').getDocuments();
  List<Division> _divisionList = [];

  snapshot.documents.forEach((documents) {
    Division division = Division.fromMap(documents.data);
    _divisionList.add(division);
  });
  divisionNotify.divisionList = _divisionList;
}

// ################## Getting Zilla Data ########################

getZilla(AllPlacesNotifier zillaNotify) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('zilla').getDocuments();
  List<Zilla> _zillaList = [];

  snapshot.documents.forEach((documents) {
    Zilla zilla = Zilla.fromMap(documents.data);
    _zillaList.add(zilla);
  });
  zillaNotify.zilla = _zillaList;
}

// ################## Getting Zilla Places Data ########################

getZillaPlaces(AllPlacesNotifier zillaPlacesNotify) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('zillaPlaces').getDocuments();
  List<ZillaPlaces> _zillaPlacesList = [];

  snapshot.documents.forEach((documents) {
    ZillaPlaces zilla = ZillaPlaces.fromMap(documents.data);
    _zillaPlacesList.add(zilla);
  });
  zillaPlacesNotify.zillaPlaces = _zillaPlacesList;
}

// ################## Divisional Places ########################

uploadImageAndLocation(Country country, File localFile, bool isUpdating) async {
  if (localFile != null) {
    print('uploading image');
    var fileExtensions = path.extension(localFile.path);

    var uuid = Uuid().v4();

    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('country/division/$uuid$fileExtensions');
    await firebaseStorageRef
        .putFile(localFile)
        .onComplete
        .catchError((onError) {
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print('Downloaded url: $url');
    // upload Country and all info
    _uploadCountry(country, isUpdating, imageUrl: url);
  } else {
    print('skipping image upload');
    _uploadCountry(country, isUpdating);
  }
}

_uploadCountry(Country country, bool isUpdating, {String imageUrl}) async {
  CollectionReference collectionReference =
      Firestore.instance.collection('country');
  if (imageUrl != null) {
    country.imageUrl = imageUrl;
  }

  if (isUpdating) {
    country.updatedAt = Timestamp.now();
    await collectionReference.document(country.id).updateData(country.toMap());
    print('File Updated at :${country.updatedAt}');
  } else {
    country.createdAt = Timestamp.now();
    DocumentReference documentReference =
        await collectionReference.add(country.toMap());
    country.id = documentReference.documentID;
    print('Country Data Create Successfully: ${country.toString()}');
    await documentReference.setData(country.toMap(), merge: true);
  }
}

// ################## Zilla  ########################

uploadZillaImageAndLocation(
    Zilla zilla, File localFile, bool isUpdating) async {
  if (localFile != null) {
    print('uploading image');
    var fileExtensions = path.extension(localFile.path);

    var uuid = Uuid().v4();

    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('country/zilla/$uuid$fileExtensions');
    await firebaseStorageRef
        .putFile(localFile)
        .onComplete
        .catchError((onError) {
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print('Downloaded url: $url');
    // upload Country and all info
    _uploadZilla(zilla, isUpdating, imageUrl: url);
  } else {
    print('skipping image upload');
    _uploadZilla(zilla, isUpdating);
  }
}

_uploadZilla(Zilla zilla, bool isUpdating, {String imageUrl}) async {
  CollectionReference collectionReference =
      Firestore.instance.collection('zilla');
  if (imageUrl != null) {
    zilla.imageUrl = imageUrl;
  }

  if (isUpdating) {
    zilla.updatedAt = Timestamp.now();
    await collectionReference.document(zilla.id).updateData(zilla.toMap());
    print('File Updated at :${zilla.updatedAt}');
  } else {
    zilla.createdAt = Timestamp.now();
    DocumentReference documentReference =
        await collectionReference.add(zilla.toMap());
    zilla.id = documentReference.documentID;
    print('Country Data Create Successfully: ${zilla.toString()}');
    await documentReference.setData(zilla.toMap(), merge: true);
  }
}

// ################## Zilla Places ########################

uploadZillaPlacesImageAndLocation(
    ZillaPlaces zillaPlaces, File localFile, bool isUpdating) async {
  if (localFile != null) {
    print('uploading image');
    var fileExtensions = path.extension(localFile.path);

    var uuid = Uuid().v4();

    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('country/zillaPlaces/$uuid$fileExtensions');
    await firebaseStorageRef
        .putFile(localFile)
        .onComplete
        .catchError((onError) {
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print('Downloaded url: $url');

    // upload Country and all info
    _uploadZillaPlaces(zillaPlaces, isUpdating, imageUrl: url);
  } else {
    print('skipping image upload');
    _uploadZillaPlaces(zillaPlaces, isUpdating);
  }
}

_uploadZillaPlaces(ZillaPlaces zillaPlaces, bool isUpdating,
    {String imageUrl}) async {
  CollectionReference collectionReference =
      Firestore.instance.collection('zillaPlaces');
  if (imageUrl != null) {
    zillaPlaces.imageUrl = imageUrl;
  }

  if (isUpdating) {
    zillaPlaces.updatedAt = Timestamp.now();
    await collectionReference
        .document(zillaPlaces.id)
        .updateData(zillaPlaces.toMap());
    print('File Updated at :${zillaPlaces.updatedAt}');
  } else {
    zillaPlaces.createdAt = Timestamp.now();
    DocumentReference documentReference =
        await collectionReference.add(zillaPlaces.toMap());
    zillaPlaces.id = documentReference.documentID;
    print('Country Data Create Successfully: ${zillaPlaces.toString()}');
    await documentReference.setData(zillaPlaces.toMap(), merge: true);
  }
}
