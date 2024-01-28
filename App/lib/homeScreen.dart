import 'package:flutter/material.dart';
import 'package:fruit_sales_app/mapScreen.dart';
import 'package:fruit_sales_app/sellsScreen.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.map), label: "Map")
        ],
      ),
      appBar: AppBar(
        title: Text("Ventas"),
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: [
          SellsScreen(),
          MapScreen(),
        ],
      ),
    );
  }
}
