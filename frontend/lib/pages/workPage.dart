import 'package:flutter/material.dart';
import 'package:frontend/pages/screens/mapScreen.dart';
import 'package:frontend/pages/screens/sellsScreenFull.dart';
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
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(199, 199, 199, 1),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Mapa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sell),
              label: 'Ventas',
            ),
          ],
          currentIndex: currentPageIndex,
          selectedItemColor: Colors.amber[800],
          onTap: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
        body: IndexedStack(
          index: currentPageIndex,
          children: [
            SlidingUpPanel(
              panel: DragPanel(),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MapScreen(
                    user_id:
                        Provider.of<userProvider>(context, listen: false).id,
                    working_day_id:
                        Provider.of<workDayProvider>(context, listen: false).id,
                  ),
                ],
              ),
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              minHeight: MediaQuery.of(context).size.height * 0.03,
              color: Colors.transparent,
            ),
            SellsScreenFull()
          ],
        ));
  }
}
