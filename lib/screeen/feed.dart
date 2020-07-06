import 'package:firedemo1/notifier/foodNotifier.dart';
import 'package:firedemo1/screeen/zilla_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/food_api.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  void initState() {
    FoodNotifier foodNotifier =
        Provider.of<FoodNotifier>(context, listen: false);
    getDivision(foodNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
      ),
      body: foodNotifier.items.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemBuilder: (ctx, ind) => ListTile(
                title: Text(
                  foodNotifier.items[ind].name,
                ),
                subtitle: Text(
                  foodNotifier.items[ind].description,
                ),
                onTap: () {
                  foodNotifier.currentDivision = foodNotifier.items[ind];
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) =>
                          ZillaPageScreen(foodNotifier.items[ind].id),
                    ),
                  );

                  // Navigator.of(context).pushNamed(
                  //   ZillaPageScreen.routeName,
                  //   arguments: {
                  //     'id': foodNotifier.items[ind].id,
                  //     'name': foodNotifier.items[ind].name,
                  //   },
                  // );
                },
              ),
              separatorBuilder: (ctx, i) => Divider(
                thickness: 1.0,
                color: Colors.grey,
              ),
              itemCount: foodNotifier.items.length,
            ),
    );
  }
}
