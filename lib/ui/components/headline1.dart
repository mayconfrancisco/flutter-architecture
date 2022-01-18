import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class Headline1 extends StatelessWidget {
  final String title;

  const Headline1({
    @required this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.headline1,
      textAlign: TextAlign.center,
    );
  }
}
