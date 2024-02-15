import 'package:flutter/material.dart';

class WidgetPrueba extends StatefulWidget {
  final String text;
  const WidgetPrueba({required this.text, Key? key}) : super(key: key);

  @override
  _WidgetPruebaState createState() => _WidgetPruebaState();
}

class _WidgetPruebaState extends State<WidgetPrueba> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.text),
    );
  }
}
