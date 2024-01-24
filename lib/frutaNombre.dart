import "package:flutter/material.dart";

class FrutaNombre extends StatefulWidget {
  final String name;
  const FrutaNombre(this.name, {super.key});

  @override
  _FrutaNombreState createState() => _FrutaNombreState();
}

class _FrutaNombreState extends State<FrutaNombre> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.name);
  }
}
