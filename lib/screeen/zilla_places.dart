import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/services_api.dart';
import '../screeen/zilla_form_screen.dart';
import '../notifier/places_Notifier.dart';

class ZillaDetailsPages extends StatefulWidget {
  final String divid;
  ZillaDetailsPages(this.divid);
  @override
  _ZillaDetailsPagesState createState() => _ZillaDetailsPagesState();
}

class _ZillaDetailsPagesState extends State<ZillaDetailsPages> {
  @override
  void initState() {
    AllPlacesNotifier detailsPageNotifier =
        Provider.of<AllPlacesNotifier>(context, listen: false);
    getZillaPlaces(detailsPageNotifier);
    super.initState();
  }

  Future<void> _refreshList() async {
    await Future.delayed(
      Duration(
        milliseconds: 800,
      ),
    );
    setState(() {
      AllPlacesNotifier detailsPageNotifier =
          Provider.of<AllPlacesNotifier>(context, listen: false);
      getZilla(detailsPageNotifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    AllPlacesNotifier detailsPageNotifier =
        Provider.of<AllPlacesNotifier>(context);
    final placesData = detailsPageNotifier.zillaPlaces.where((prod) {
      return prod.categories.contains(widget.divid);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(detailsPageNotifier.currentZilla.name),
      ),
      body: placesData.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              strokeWidth: 10,
              color: Colors.black,
              onRefresh: _refreshList,
              child: ListView.builder(
                  itemBuilder: (ctx, i) => ListTile(
                        title: Text(placesData[i].name),
                        onTap: () {
                          // currentPageTitle.currentZilla = zillaData[i];
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (ctx) => null,
                          //   ),
                          // );
                        },
                      ),
                  itemCount: placesData.length),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // feedNotifier.currentCountry = null;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ZillaFormScreen(
                isUpdating: false,
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}