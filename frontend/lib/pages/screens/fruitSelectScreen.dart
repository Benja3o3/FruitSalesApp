import 'package:flutter/material.dart';

class FruitSelectScreen extends StatefulWidget {
  const FruitSelectScreen({Key? key}) : super(key: key);

  @override
  _FruitSelectScreenState createState() => _FruitSelectScreenState();
}

class _FruitSelectScreenState extends State<FruitSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: const Color.fromRGBO(199, 199, 199, 1),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: Text(
                "Selecciona las frutas para este día",
                style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.none,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Text("Aqui van las frutas"),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Go back"),
            ),
          ],
        ),
      ),
    );
  }
}
