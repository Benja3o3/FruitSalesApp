// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:frontend/api/fruitQuerys.dart';
import 'package:frontend/models/fruitSell.dart';
import 'package:frontend/providers/userProvider.dart';
import 'package:frontend/providers/workDayProvider.dart';
import 'package:provider/provider.dart';

class FruitAddSellCard extends StatefulWidget {
  final FruitSell fruit;
  final Function refresh;
  const FruitAddSellCard({required this.refresh, required this.fruit, Key? key})
      : super(key: key);

  @override
  _FruitAddSellCardState createState() => _FruitAddSellCardState();
}

class _FruitAddSellCardState extends State<FruitAddSellCard> {
  final FruitQuerys fruitQuerys = FruitQuerys();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
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
          style: const TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 20),
        ),
        Row(
          children: [
            Text(
              widget.fruit.cantidad,
              style: const TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 20),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () async {
                  if (widget.fruit.cantidad == "0") {
                    return;
                  }
                  final user_id =
                      Provider.of<userProvider>(context, listen: false).id;
                  final working_day_id =
                      Provider.of<workDayProvider>(context, listen: false).id;
                  final fruit_id = widget.fruit.id;
                  await fruitQuerys.removeFruitSell(
                      user_id, working_day_id, fruit_id);
                  widget.refresh();
                },
                icon: const Icon(Icons.remove_circle_outline)),
            IconButton(
                onPressed: () async {
                  final user_id =
                      Provider.of<userProvider>(context, listen: false).id;
                  final working_day_id =
                      Provider.of<workDayProvider>(context, listen: false).id;
                  final fruit_id = widget.fruit.id;
                  await fruitQuerys.addFruitSell(
                      user_id, working_day_id, fruit_id);
                  widget.refresh();
                },
                icon: const Icon(Icons.add_circle_outline)),
          ],
        )
      ]),
    );
  }
}
