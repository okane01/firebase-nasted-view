import 'package:firedemo1/notifier/places_Notifier.dart';
import 'package:firedemo1/screeen/formScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AllPlacesNotifier currentPage =
        Provider.of<AllPlacesNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentPage.currentCountry.name,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Hero(
                  tag: currentPage.currentCountry.id,
                  child: Image(
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      currentPage.currentCountry.imageUrl != null
                          ? currentPage.currentCountry.imageUrl
                          : 'https://lunawood.com/wp-content/uploads/2018/02/placeholder-image.png',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  currentPage.currentCountry.name,
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 28,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  currentPage.currentCountry.description,
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  children: currentPage.currentCountry.subPlaces
                      .map(
                        (e) => Card(
                          elevation: 8,
                          color: Colors.black54,
                          child: Center(
                            child: Text(
                              e,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => FormScreen(
                isUpdating: true,
              ),
            ),
          );
        },
        child: Icon(
          Icons.edit,
        ),
      ),
    );
  }
}
