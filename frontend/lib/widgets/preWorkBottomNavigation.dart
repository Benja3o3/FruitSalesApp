import 'package:flutter/material.dart';

class PreWorkBottomNavigation extends StatefulWidget {
  final currentPageIndex;
  final ValueChanged<int> onItemTapped;
  const PreWorkBottomNavigation(
      {required this.currentPageIndex, required this.onItemTapped, Key? key})
      : super(key: key);

  @override
  _PreWorkBottomNavigationState createState() =>
      _PreWorkBottomNavigationState();
}

class _PreWorkBottomNavigationState extends State<PreWorkBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: widget.currentPageIndex,
        onTap: (index) {
          widget.onItemTapped(index);
        },
        selectedItemColor: Color.fromRGBO(255, 255, 255, 1),
        backgroundColor: Color.fromRGBO(49, 49, 49, 1),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Ajustes"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ]);
  }
}
