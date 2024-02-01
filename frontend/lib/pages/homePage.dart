import 'package:flutter/material.dart';
import 'package:frontend/pages/screens/profileScreen.dart';
import 'package:frontend/pages/screens/settingsScreen.dart';
import 'package:frontend/widgets/preWorkBottomNavigation.dart';
import 'package:frontend/pages/screens/homeScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: PreWorkBottomNavigation(
          currentPageIndex: currentPageIndex,
          onItemTapped: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
        backgroundColor: const Color.fromRGBO(199, 199, 199, 1),
        body: <Widget>[
          const SettingsScreen(),
          const HomeScreen(),
          const ProfileScreen()
        ][currentPageIndex]);
  }
}
