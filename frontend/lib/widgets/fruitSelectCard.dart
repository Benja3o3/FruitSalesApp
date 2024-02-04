import 'package:flutter/material.dart';

class FruitSelectCard extends StatefulWidget {
  const FruitSelectCard({Key? key}) : super(key: key);

  @override
  _FruitSelectCardState createState() => _FruitSelectCardState();
}

class _FruitSelectCardState extends State<FruitSelectCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.4,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(191, 191, 191, 1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
          children: [Icon(Icons.apple), Text("Apple"), Text("Total vendido")]),
    );
  }
}
