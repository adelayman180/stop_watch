import 'package:flutter/material.dart';
import './home_page.dart';

main(List<String> args) {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(accentColor: Colors.grey),
  ));
}
