import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'division_page.dart';
import '../services/services_api.dart';
import '../notifier/places_Notifier.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  AllPlacesNotifier current;
  @override
  void didChangeDependencies() {
    AllPlacesNotifier allPlacesNotifier =
        Provider.of<AllPlacesNotifier>(context);
    getCountry(allPlacesNotifier);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    AllPlacesNotifier allPlacesNotifier =
        Provider.of<AllPlacesNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Division List'),
      ),
      body: allPlacesNotifier.countryList.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemBuilder: (ctx, ind) => ListTile(
                title: Text(
                  allPlacesNotifier.countryList[ind].name,
                ),
                subtitle: Text(
                  allPlacesNotifier.countryList[ind].description,
                ),
                onTap: () {
                  allPlacesNotifier.currentCountry =
                      allPlacesNotifier.countryList[ind];
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => DivisionPage(
                       id: allPlacesNotifier.countryList[ind].id,
                      ),
                    ),
                  );
                },
              ),
              separatorBuilder: (ctx, i) => Divider(
                thickness: 1.0,
                color: Colors.grey,
              ),
              itemCount: allPlacesNotifier.countryList.length,
            ),
    );
  }
}
