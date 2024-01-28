import 'package:flutter/material.dart';

class RestartPopup extends StatefulWidget {
  const RestartPopup({Key? key}) : super(key: key);

  @override
  _RestartPopupState createState() => _RestartPopupState();
}

class _RestartPopupState extends State<RestartPopup> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "¿Estas seguro de querer reiniciar las ventas?",
      style: TextStyle(fontSize: 18),
    );
  }
}
