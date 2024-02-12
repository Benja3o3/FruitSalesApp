import 'package:flutter/material.dart';
import 'package:frontend/pages/screens/sellsScreen.dart';
import 'package:frontend/widgets/sellsDragPanel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SellsScreenFull extends StatefulWidget {
  const SellsScreenFull({Key? key}) : super(key: key);

  @override
  _SellsScreenFullState createState() => _SellsScreenFullState();
}

class _SellsScreenFullState extends State<SellsScreenFull> {
  Key _uniqueKey = UniqueKey();

  void refreshData() {
    setState(() {
      _uniqueKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      panel: SellsDragPanel(
        refresh: refreshData,
      ),
      body: SellsScreen(
        refresh: refreshData,
      ),
      maxHeight: MediaQuery.of(context).size.height * 0.5,
      minHeight: MediaQuery.of(context).size.height * 0.03,
      color: Colors.transparent,
    );
  }
}
