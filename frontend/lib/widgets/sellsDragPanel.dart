import 'package:flutter/material.dart';
import 'package:frontend/api/fruitQuerys.dart';
import 'package:frontend/providers/userProvider.dart';
import 'package:frontend/providers/workDayProvider.dart';
import 'package:provider/provider.dart';

class SellsDragPanel extends StatefulWidget {
  final Function refresh;
  const SellsDragPanel({required this.refresh, Key? key}) : super(key: key);

  @override
  _SellsDragPanelState createState() => _SellsDragPanelState();
}

class _SellsDragPanelState extends State<SellsDragPanel> {
  final FruitQuerys fruitQuerys = FruitQuerys();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(199, 199, 199, 1),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            Icon(Icons.menu),
            SizedBox(
              height: 10,
            ),
            Text(
              "RESUMEN",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: FutureBuilder(
                future: fruitQuerys.getFruitSell(
                    Provider.of<userProvider>(context, listen: false).id,
                    Provider.of<workDayProvider>(context, listen: false).id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, i) {
                        return Center(
                          child: Text(
                            "${snapshot.data![i].name} : ${snapshot.data![i].cantidad} -> ${int.parse(snapshot.data![i].cantidad) * snapshot.data![i].price}",
                            style: TextStyle(fontSize: 20),
                          ),
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
            Expanded(
                child: FutureBuilder(
              future: fruitQuerys.getFruitTotals(
                  Provider.of<workDayProvider>(context).id,
                  Provider.of<userProvider>(context).id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total de potes: ${snapshot.data["totalpotes"]}",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text("Total dinero: ${snapshot.data["totaldinero"]}",
                          style: TextStyle(fontSize: 20))
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
            ))
          ],
        ));
  }
}
