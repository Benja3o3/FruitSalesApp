import 'package:flutter/material.dart';
import 'package:frontend/pages/screens/homeScreen.dart';
import 'package:frontend/providers/userProvider.dart';
import 'package:frontend/providers/workDayProvider.dart';
import 'package:provider/provider.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({Key? key}) : super(key: key);

  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Work Page"),
        ElevatedButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Text("Go back")),
        Text(context.watch<workDayProvider>().id.toString()),
        Text(context.watch<userProvider>().id.toString())
      ],
    ));
  }
}
