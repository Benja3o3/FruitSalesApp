import 'package:flutter/material.dart';

class FruitCard extends StatefulWidget {
  final String fruitName;
  final int fruitCount;
  final VoidCallback incrementCount;
  final VoidCallback decrementCount;
  const FruitCard({
    Key? key,
    required this.fruitName,
    required this.fruitCount,
    required this.incrementCount,
    required this.decrementCount,
  }) : super(key: key);

  @override
  _FruitCardState createState() => _FruitCardState();
}

class _FruitCardState extends State<FruitCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Text(
              widget.fruitName,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            child: Center(
              child: Text(
                widget.fruitCount.toString(),
                style: const TextStyle(fontSize: 25),
              ),
            ),
          ),
          TextButton(
            onPressed: widget.decrementCount,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            child: const Text(
              "-",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          TextButton(
            onPressed: widget.incrementCount,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            child: const Text(
              "+",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
