import 'package:flutter/material.dart';
import 'package:flutter_architecture/ui/pages/pages.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: '4Dev', home: LoginPage());
  }
}
