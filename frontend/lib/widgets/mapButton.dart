import 'package:flutter/material.dart';

class MapButton extends StatefulWidget {
  final Color color;
  final Icon icon;
  final Function onPressed;
  const MapButton(
      {required this.color,
      required this.icon,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  _MapButtonState createState() => _MapButtonState();
}

class _MapButtonState extends State<MapButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => widget.onPressed(),
        icon: widget.icon,
        style: ButtonStyle(
          shadowColor: MaterialStateProperty.all(Colors.black),
          elevation: MaterialStateProperty.all(10),
          backgroundColor: MaterialStateProperty.all(widget.color),
          iconColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0), // Radio del botón
            ),
          ),
        ));
  }
}
