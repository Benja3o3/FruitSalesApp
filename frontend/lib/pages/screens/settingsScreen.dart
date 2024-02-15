import 'package:flutter/material.dart';
import 'package:frontend/providers/fruitProvider.dart';
import 'package:frontend/providers/workDayProvider.dart';
import 'package:frontend/widgets/widgetPrueba.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String text = "Hola";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(context.watch<workDayProvider>().id.toString()),
          Text(context.watch<fruitProvider>().fruitSelected.toString()),
          WidgetPrueba(text: text),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  text = "Adios";
                });
              },
              child: Text("Cambiar texto"))
        ],
      ),
    );
  }
}
