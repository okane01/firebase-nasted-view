import 'package:firedemo1/model/zilla.dart';
import 'package:firedemo1/notifier/foodNotifier.dart';
import 'package:firedemo1/services/food_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZillaPageScreen extends StatefulWidget {
  static const routeName = '/zilla-page';
  final String id;
  ZillaPageScreen(this.id);

  @override
  _ZillaPageScreenState createState() => _ZillaPageScreenState();
}

class _ZillaPageScreenState extends State<ZillaPageScreen> {
  @override
  Widget build(BuildContext context) {
    List<Zillas> prodData =
        Provider.of<FoodNotifier>(context).zilla.where((prod) {
      return prod.categories.contains(widget.id);
    }).toList();

    FoodNotifier foodNotifier =
        Provider.of<FoodNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(foodNotifier.currentDivision.name),
      ),
      body: prodData.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (ctx, i) => ListTile(
                title: Text(prodData[i].name),
              ),
              itemCount: prodData.length,
            ),
    );
  }
}
