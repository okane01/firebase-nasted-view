import 'package:firedemo1/notifier/places_Notifier.dart';
import 'package:firedemo1/screeen/zilla_form_screen.dart';
import 'package:firedemo1/screeen/zilla_places.dart';
import 'package:firedemo1/services/services_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZillaPage extends StatefulWidget {
  final String divid;
  ZillaPage({this.divid});
  @override
  _ZillaPageState createState() => _ZillaPageState();
}

class _ZillaPageState extends State<ZillaPage> {
  @override
  void initState() {
    AllPlacesNotifier currentPageTitle =
        Provider.of<AllPlacesNotifier>(context, listen: false);
    getZilla(currentPageTitle);
    super.initState();
  }

  Future<void> _refreshList() async {
    await Future.delayed(
      Duration(
        milliseconds: 800,
      ),
    );
    setState(() {
      AllPlacesNotifier feedNotifier =
          Provider.of<AllPlacesNotifier>(context, listen: false);
      getZilla(feedNotifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    AllPlacesNotifier currentPageTitle =
        Provider.of<AllPlacesNotifier>(context);
    final zillaData = currentPageTitle.zilla.where((prod) {
      return prod.categories.contains(widget.divid);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Zilla Page Screen'),
      ),
      body: zillaData.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              strokeWidth: 10,
              color: Colors.black,
              onRefresh: _refreshList,
              child: ListView.builder(
                  itemBuilder: (ctx, i) => ListTile(
                        title: Text(zillaData[i].name),
                        onTap: () {
                          currentPageTitle.currentZilla = zillaData[i];
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  ZillaDetailsPages(zillaData[i].divid),
                            ),
                          );
                        },
                      ),
                  itemCount: zillaData.length),
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
