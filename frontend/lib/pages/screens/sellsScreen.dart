import 'package:flutter/material.dart';
import 'package:frontend/api/fruitQuerys.dart';
import 'package:frontend/providers/fruitProvider.dart';
import 'package:frontend/providers/userProvider.dart';
import 'package:frontend/providers/workDayProvider.dart';
import 'package:frontend/widgets/fruitAddSellCard.dart';
import 'package:provider/provider.dart';

class SellsScreen extends StatefulWidget {
  final Function refresh;
  const SellsScreen({required this.refresh, Key? key}) : super(key: key);

  @override
  _SellsScreenState createState() => _SellsScreenState();
}

class _SellsScreenState extends State<SellsScreen> {
  final FruitQuerys fruitQuerys = FruitQuerys();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 50),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          "Ventas del día",
          style: TextStyle(fontSize: 40),
        ),
        Expanded(
          child: FutureBuilder(
            future: fruitQuerys.getFruitSell(
                Provider.of<userProvider>(context, listen: false).id,
                Provider.of<workDayProvider>(context, listen: false).id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemBuilder: (context, i) {
                    return FruitAddSellCard(
                      fruit: snapshot.data![i],
                      refresh: widget.refresh,
                    );
                  },
                  itemCount: snapshot.data!.length,
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 08,
          decoration: BoxDecoration(
              color: Color.fromRGBO(232, 232, 232, 1),
              borderRadius: BorderRadius.circular(40)),
          child: Text(
              "Total: " + context.watch<fruitProvider>().totalPotes.toString(),
              style: TextStyle(fontSize: 40)),
        )
      ]),
    );
  }
}
