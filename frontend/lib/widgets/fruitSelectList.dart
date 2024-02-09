import 'package:flutter/material.dart';
import 'package:frontend/models/fruit.dart';
import 'package:frontend/widgets/fruitSelectCard.dart';

class FruitSelectList extends StatefulWidget {
  final List<Fruit> fruits;
  const FruitSelectList({required this.fruits, Key? key}) : super(key: key);

  @override
  _FruitSelectListState createState() => _FruitSelectListState();
}

class _FruitSelectListState extends State<FruitSelectList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(widget.fruits[i].name),
          );
        },
        itemCount: widget.fruits.length);
  }
}
