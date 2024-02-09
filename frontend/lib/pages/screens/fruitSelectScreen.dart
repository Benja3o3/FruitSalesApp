import 'package:flutter/material.dart';
import 'package:frontend/api/fruitQuerys.dart';
import 'package:frontend/pages/workPage.dart';
import 'package:frontend/providers/fruitProvider.dart';
import 'package:frontend/widgets/fruitSelectCard.dart';
import 'package:frontend/widgets/fruitSelectList.dart';
import 'package:provider/provider.dart';

class FruitSelectScreen extends StatefulWidget {
  const FruitSelectScreen({Key? key}) : super(key: key);

  @override
  _FruitSelectScreenState createState() => _FruitSelectScreenState();
}

class _FruitSelectScreenState extends State<FruitSelectScreen> {
  final FruitQuerys fruitQuerys = FruitQuerys();
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
            Expanded(
              child: FutureBuilder(
                  future: fruitQuerys.getFruits(),
                  builder: (context, snapshot) {
                    print(snapshot.connectionState);
                    if (snapshot.connectionState == ConnectionState.done) {
                      print(snapshot.data!);
                      // FruitSelectList(fruits: snapshot.data!);
                      return ListView.builder(
                        itemBuilder: (context, i) {
                          final isStartOfRow = i % 2 == 0;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Adjust spacing as needed
                            children: [
                              if (isStartOfRow)
                                FruitSelectCard(
                                  fruit: snapshot.data![i],
                                ),
                              if (i + 1 < snapshot.data!.length && isStartOfRow)
                                FruitSelectCard(
                                  fruit: snapshot.data![i + 1],
                                ),
                            ],
                          );
                        },
                        itemCount: snapshot.data!.length,
                      );
                    }
                    return CircularProgressIndicator();
                  }),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WorkPage()));
                },
                child: Text("Continuar")),
            ElevatedButton(
              onPressed: () {
                context.read<fruitProvider>().clearFruit();
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
