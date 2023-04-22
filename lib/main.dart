import 'package:flutter/material.dart';
import 'package:myapp/pages/splash.dart';
import 'package:myapp/states/CurrentPage.dart';
import 'package:myapp/states/SelectedAddress.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(MultiProvider(child: App(), providers: [
    ChangeNotifierProvider(create: (_) => CurrentPage()),
    ChangeNotifierProvider(create: (_) => SelectedAddress())
  ]));
}

Widget App() {
  return MaterialApp(home: Splash(), debugShowCheckedModeBanner: false);
}
