// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:frontend/api/fruitQuerys.dart';
import 'package:frontend/pages/workPage.dart';
import 'package:frontend/providers/fruitProvider.dart';
import 'package:frontend/providers/userProvider.dart';
import 'package:frontend/providers/workDayProvider.dart';
import 'package:frontend/widgets/fruitSelectCard.dart';
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
              child: const Text(
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
                    if (snapshot.connectionState == ConnectionState.done) {
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
                    return const CircularProgressIndicator();
                  }),
            ),
            ElevatedButton(
                onPressed: () async {
                  final workingDayId =
                      Provider.of<workDayProvider>(context, listen: false).id;
                  final fruit_id =
                      Provider.of<fruitProvider>(context, listen: false)
                          .fruitSelected;
                  final created_by =
                      Provider.of<userProvider>(context, listen: false).id;
                  await fruitQuerys.newDay(workingDayId);
                  await fruitQuerys.newDayWithFruits(
                      workingDayId, fruit_id, created_by);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WorkPage()));
                },
                child: const Text("Continuar")),
            ElevatedButton(
              onPressed: () {
                context.read<fruitProvider>().clearFruit();
                Navigator.pop(context);
              },
              child: const Text("Go back"),
            ),
          ],
        ),
      ),
    );
  }
}
