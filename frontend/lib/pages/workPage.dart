import 'package:flutter/material.dart';
import 'package:frontend/pages/screens/homeScreen.dart';
import 'package:frontend/pages/screens/mapScreen.dart';
import 'package:frontend/providers/fruitProvider.dart';
import 'package:frontend/providers/userProvider.dart';
import 'package:frontend/providers/workDayProvider.dart';
import 'package:frontend/widgets/dragPanel.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({Key? key}) : super(key: key);

  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(199, 199, 199, 1),
        body: SlidingUpPanel(
          panel: DragPanel(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MapScreen(),
            ],
          ),
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          minHeight: MediaQuery.of(context).size.height * 0.05,
          color: Colors.transparent,
        ));
  }
}
