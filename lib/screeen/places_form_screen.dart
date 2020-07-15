import 'dart:io';

import 'package:firedemo1/model/zilla_places.dart';
import 'package:firedemo1/notifier/places_Notifier.dart';
import 'package:firedemo1/services/services_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PlacesFormScreen extends StatefulWidget {
  final bool isUpdating;
  PlacesFormScreen({this.isUpdating});
  @override
  _PlacesFormScreenState createState() => _PlacesFormScreenState();
}

class _PlacesFormScreenState extends State<PlacesFormScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ZillaPlaces _currentPlaces;
  TextEditingController _subLocationController = TextEditingController();
  //Another part
  List _subZillaList = [];
  String _imageUrl;
  //local Strorage Option here
  File _localImage;
  final _picker = ImagePicker();

  Widget _showImage() {
    if (_localImage == null && _imageUrl == null) {
      return Image.asset(
        'assets/placeholder-image.png',
        width: double.infinity,
        height: 120,
      );
    } else if (_localImage != null) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            _localImage,
            fit: BoxFit.cover,
            height: 220,
            width: double.infinity,
          ),
          FlatButton(
            padding: const EdgeInsets.all(
              10.0,
            ),
            color: Colors.black45,
            onPressed: () => _selectLocalImage(),
            child: Text(
              'ছবি নির্বাচন করুন',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    } else if (_imageUrl != null) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(
            _imageUrl,
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
          ),
          FlatButton(
            padding: const EdgeInsets.all(
              10.0,
            ),
            color: Colors.black45,
            onPressed: () => _selectLocalImage(),
            child: Text(
              'ছবি নির্বাচন করুন',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    }
    return null;
  }

  _selectLocalImage() async {
    PickedFile pickedImage =
        await _picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _localImage = File(pickedImage.path);
      });
    }
  }

  @override
  initState() {
    super.initState();
    AllPlacesNotifier zillaNotifier =
        Provider.of<AllPlacesNotifier>(context, listen: false);
    if (zillaNotifier.currentZillaPlaces != null) {
      _currentPlaces = zillaNotifier.currentZillaPlaces;
      _subZillaList.addAll(_currentPlaces.categories);
      _imageUrl = zillaNotifier.currentZilla.imageUrl;
    } else {
      _currentPlaces = ZillaPlaces();
    }
  }

  Widget _showNameWidget() {
    return TextFormField(
        initialValue: _currentPlaces.name,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'স্থানের নাম',
        ),
        onSaved: (String name) {
          _currentPlaces.name = name;
        },
        validator: (String value) {
          if (value.isEmpty) {
            return 'নাম';
          }
          if (value.length < 3 || value.length > 20) {
            return 'সঠিক নয়';
          }
          return null;
        });
  }

  Widget _showDetailsWidget() {
    return TextFormField(
        initialValue: _currentPlaces.description,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: 'স্থানের বর্ণনা',
          // labelText: 'স্থানের সংক্ষিপ্ত বর্ণনা',
        ),
        onSaved: (String description) {
          _currentPlaces.description = description;
        },
        validator: (String value) {
          if (value.isEmpty) {
            return 'বর্ণনা নেই';
          }
          if (value.length < 3) {
            return 'বর্ণনার ফরমেট ঠিক নাই';
          }
          return null;
        });
  }

  Widget _subLocationField() {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: _subLocationController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'জেলার নাম',
        ),
      ),
    );
  }

  subLocationButton(String name) {
    if (name.isNotEmpty) {
      setState(() {
        _subZillaList.add(name);
      });
      _subLocationController.clear();
    }
  }

  _saveFile() {
    print('Strart Uploading...');
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    print('Strart Finished');
    _currentPlaces.categories = _subZillaList;
    uploadPlacesImageAndLocation(
        _currentPlaces, _localImage, widget.isUpdating);
    Navigator.of(context).pop();
  }

  Widget _showParentWidget() {
    return TextFormField(
        initialValue: _currentPlaces.divid,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'উপজেলার নাম',
        ),
        onSaved: (String divid) {
          _currentPlaces.divid = divid;
        },
        validator: (String value) {
          if (value.isEmpty) {
            return 'স্থানের নাম দরকার';
          }
          if (value.length < 3 || value.length > 20) {
            return 'ঠিক নাই।';
          }
          return null;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('স্থানের তথ্য '),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: null,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Form(
              autovalidate: true,
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _showImage(),
                  _localImage == null && _imageUrl == null
                      ? ButtonTheme(
                          child: RaisedButton(
                            onPressed: () => _selectLocalImage(),
                            child: Text('ছবি'),
                          ),
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  _showNameWidget(),
                  SizedBox(
                    height: 10,
                  ),
                  _showParentWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _subLocationField(),
                      ButtonTheme(
                        child: RaisedButton(
                          onPressed: () =>
                              subLocationButton(_subLocationController.text),
                          child: Text(
                            'সংরক্ষন করুন',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: _subZillaList
                        .map(
                          (subLocations) => Card(
                            color: Colors.black54,
                            child: Center(
                              child: Text(
                                subLocations,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  _showDetailsWidget(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _saveFile(),
        child: Icon(
          Icons.save,
        ),
      ),
    );
  }
}
