import 'package:flutter/material.dart';
import 'package:frontend/models/fruitSell.dart';

class FruitAddSellCard extends StatefulWidget {
  final FruitSell fruit;
  const FruitAddSellCard({required this.fruit, Key? key}) : super(key: key);

  @override
  _FruitAddSellCardState createState() => _FruitAddSellCardState();
}

class _FruitAddSellCardState extends State<FruitAddSellCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(191, 191, 191, 1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          height: 40,
          width: 40,
          child: Image.asset("assets/${widget.fruit.icon}"),
        ),
        Text(
          widget.fruit.name.toString(),
          style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 20),
        ),
        Row(
          children: [
            Text(
              widget.fruit.cantidad,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 20),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.remove_circle_outline)),
            IconButton(onPressed: () {}, icon: Icon(Icons.add_circle_outline)),
          ],
        )
      ]),
    );
  }
}
