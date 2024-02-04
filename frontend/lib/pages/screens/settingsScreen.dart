import 'package:flutter/material.dart';
import 'package:frontend/providers/workDayProvider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(context.watch<workDayProvider>().id.toString()),
      ),
    );
  }
}
