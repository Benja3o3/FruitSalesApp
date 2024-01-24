import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InformationCard extends StatefulWidget {
  final List<int> fruitCounts;
  final List<String> fruitList;
  final List<int> fruitSells;
  final int totalSells;
  const InformationCard(
      {Key? key,
      required this.fruitCounts,
      required this.fruitList,
      required this.fruitSells,
      required this.totalSells})
      : super(key: key);

  @override
  _InformationCardState createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {
  NumberFormat formatoDinero =
      NumberFormat.currency(locale: 'es_CL', symbol: '\$');
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      width: MediaQuery.of(context).size.width * 0.9,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Resumen",
              style: TextStyle(fontSize: 20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total de potes vendidos = ${widget.fruitCounts.reduce((value, element) => value + element)}",
                  style: const TextStyle(fontSize: 16),
                ),
                for (int i = 0; i < widget.fruitList.length; i++)
                  Text(
                      "Total vendido con ${widget.fruitList[i]} = ${formatoDinero.format(widget.fruitSells[i])}",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                Text(
                  "Total Dinero = ${formatoDinero.format(widget.totalSells)}",
                  style: TextStyle(fontSize: 25),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
