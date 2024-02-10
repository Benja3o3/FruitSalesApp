import 'package:flutter/material.dart';
import 'package:frontend/models/fruit.dart';
import 'package:frontend/providers/fruitProvider.dart';
import 'package:provider/provider.dart';

class FruitSelectCard extends StatefulWidget {
  final Fruit fruit;
  const FruitSelectCard({required this.fruit, Key? key}) : super(key: key);

  @override
  _FruitSelectCardState createState() => _FruitSelectCardState();
}

class _FruitSelectCardState extends State<FruitSelectCard> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        if (_isSelected) {
          Provider.of<fruitProvider>(context, listen: false)
              .addFruit(widget.fruit.id);
        } else {
          Provider.of<fruitProvider>(context, listen: false)
              .removeFruit(widget.fruit.id);
        }

        print(Provider.of<fruitProvider>(context, listen: false).fruitSelected);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _isSelected
              ? const Color.fromRGBO(150, 150, 150, 1)
              : const Color.fromRGBO(191, 191, 191, 1),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset("assets/${widget.fruit.icon}"),
          ),
          Text(
            widget.fruit.name,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 20),
          ),
          Text(
            widget.fruit.price.toString(),
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 20),
          )
        ]),
      ),
    );
  }
}
