import 'package:firedemo1/screeen/zilla_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/services_api.dart';
import '../notifier/places_Notifier.dart';

class DivisionPage extends StatefulWidget {
  final String id;
  DivisionPage({
    this.id,
  });
  @override
  _DivisionPageState createState() => _DivisionPageState();
}

class _DivisionPageState extends State<DivisionPage> {
  @override
  void initState() {
    AllPlacesNotifier currentPageTitle =
        Provider.of<AllPlacesNotifier>(context, listen: false);
    getDivision(currentPageTitle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AllPlacesNotifier currentPageTitle =
        Provider.of<AllPlacesNotifier>(context);
    final prodData = currentPageTitle.divisionList.where((prod) {
      return prod.categories.contains(widget.id);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(currentPageTitle.currentCountry.name),
      ),
      body: prodData.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (ctx, i) => ListTile(
                title: Text(prodData[i].name),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ZillaPage(
                        divid: prodData[i].id,
                      ),
                    ),
                  );
                },
              ),
              itemCount: prodData.length,
            ),
    );
  }
}
