import 'package:firedemo1/notifier/places_Notifier.dart';
import 'package:firedemo1/screeen/formScreen.dart';
import 'package:firedemo1/screeen/zilla_page.dart';
import 'package:firedemo1/services/services_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  void initState() {
    super.initState();
    AllPlacesNotifier feedNotifier =
        Provider.of<AllPlacesNotifier>(context, listen: false);
    getCountry(feedNotifier);
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
      getCountry(feedNotifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilding');
    AllPlacesNotifier feedNotifier = Provider.of<AllPlacesNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed Screen'),
      ),
      body: feedNotifier.countryList.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _refreshList,
              child: ListView.builder(
                itemBuilder: (ctx, i) => ListTile(
                  leading: Hero(
                    tag: feedNotifier.countryList[i].id,
                    child: Image.network(
                      feedNotifier.countryList[i].imageUrl != null
                          ? feedNotifier.countryList[i].imageUrl
                          : 'https://lunawood.com/wp-content/uploads/2018/02/placeholder-image.png',
                      width: 100,
                    ),
                  ),
                  title: Text(feedNotifier.countryList[i].name),
                  subtitle: Text(feedNotifier.countryList[i].description),
                  onTap: () {
                    feedNotifier.currentCountry = feedNotifier.countryList[i];
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ZillaPage(
                          divid: feedNotifier.countryList[i].divid,
                        ),
                      ),
                    );
                  },
                ),
                itemCount: feedNotifier.countryList.length,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          feedNotifier.currentCountry = null;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => FormScreen(
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
