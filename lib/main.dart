import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'notifier/places_Notifier.dart';

import './screeen/feed.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AllPlacesNotifier>(
          create: (ctx) => AllPlacesNotifier(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Feed(),
      ),
    );
  }
}
