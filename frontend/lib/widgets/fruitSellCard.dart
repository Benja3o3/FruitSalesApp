import 'package:flutter/material.dart';
import 'package:frontend/models/fruitSell.dart';

class FruitSellCard extends StatefulWidget {
  final FruitSell fruit;
  const FruitSellCard({required this.fruit, Key? key}) : super(key: key);

  @override
  _FruitSellCardState createState() => _FruitSellCardState();
}

class _FruitSellCardState extends State<FruitSellCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(191, 191, 191, 1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Image.asset("assets/${widget.fruit.icon}"),
        ),
        Text(
          "Potes: ${widget.fruit.cantidad}",
          style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 20),
        ),
        Text(
          (int.parse(widget.fruit.cantidad) * widget.fruit.price).toString(),
          style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 20),
        )
      ]),
    );
  }
}
