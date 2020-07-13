import 'dart:io';

import 'package:firedemo1/model/country.dart';
import 'package:firedemo1/notifier/places_Notifier.dart';
import 'package:firedemo1/services/services_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  final bool isUpdating;
  FormScreen({
    @required this.isUpdating,
  });
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Country _currentCountry;
  TextEditingController _subLocationController = TextEditingController();
  //Another part
  List _subCountryList = [];
  String _imageUrl;
  //local Strorage Option here
  File _localImage;
  final _picker = ImagePicker();

  Widget _showImage() {
    if (_localImage == null && _imageUrl == null) {
      return Text('Please upload image');
    } else if (_localImage != null) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            _localImage,
            fit: BoxFit.cover,
          ),
          FlatButton(
            padding: const EdgeInsets.all(
              10.0,
            ),
            color: Colors.black45,
            onPressed: () => _selectLocalImage(),
            child: Text(
              'Select LocalImage',
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
              'Select LocalImage',
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
    AllPlacesNotifier countryNotifier =
        Provider.of<AllPlacesNotifier>(context, listen: false);
    if (countryNotifier.currentCountry != null) {
      _currentCountry = countryNotifier.currentCountry;
      _subCountryList.addAll(_currentCountry.subPlaces);
      _imageUrl = countryNotifier.currentCountry.imageUrl;
    } else {
      _currentCountry = Country();
    }
  }

  Widget _showNameWidget() {
    return TextFormField(
        initialValue: _currentCountry.name,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Name',
        ),
        onSaved: (String name) {
          _currentCountry.name = name;
        },
        validator: (String value) {
          if (value.isEmpty) {
            return 'Category is required';
          }
          if (value.length < 3 || value.length > 20) {
            return 'Incorrect value';
          }
          return null;
        });
  }

  Widget _showDetailsWidget() {
    return TextFormField(
        initialValue: _currentCountry.description,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Description',
        ),
        onSaved: (String description) {
          _currentCountry.description = description;
        },
        validator: (String value) {
          if (value.isEmpty) {
            return 'Category is required';
          }
          if (value.length < 3 || value.length > 200) {
            return 'Incorrect value';
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
          labelText: 'Division',
        ),
      ),
    );
  }

  subLocationButton(String name) {
    if (name.isNotEmpty) {
      setState(() {
        _subCountryList.add(name);
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
    _currentCountry.subPlaces = _subCountryList;
    uploadImageAndLocation(_currentCountry, _localImage, widget.isUpdating);
    Navigator.of(context).pop();
  }

  Widget _showParentWidget() {
    return TextFormField(
        initialValue: _currentCountry.divid,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'parent name',
        ),
        onSaved: (String divid) {
          _currentCountry.divid = divid;
        },
        validator: (String value) {
          if (value.isEmpty) {
            return 'Category is required';
          }
          if (value.length < 3 || value.length > 20) {
            return 'Incorrect value';
          }
          return null;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Screen'),
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
                            child: Text('Open Image'),
                          ),
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  _showNameWidget(),
                  _showDetailsWidget(),
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
                            'Save',
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
                    children: _subCountryList
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
