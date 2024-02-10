import 'package:flutter/material.dart';
import 'package:frontend/api/fruitQuerys.dart';
import 'package:frontend/providers/fruitProvider.dart';
import 'package:frontend/providers/userProvider.dart';
import 'package:frontend/providers/workDayProvider.dart';
import 'package:frontend/widgets/fruitSellCard.dart';
import 'package:provider/provider.dart';

class DragPanel extends StatefulWidget {
  const DragPanel({Key? key}) : super(key: key);

  @override
  _DragPanelState createState() => _DragPanelState();
}

class _DragPanelState extends State<DragPanel> {
  final FruitQuerys fruitQuerys = FruitQuerys();

  int totalPotes = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(199, 199, 199, 1),
          borderRadius: BorderRadius.circular(50)),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          Icon(Icons.menu),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(232, 232, 232, 1),
                borderRadius: BorderRadius.circular(40)),
            padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                Text(
                  "Id día de trabajo",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  context.read<workDayProvider>().id.toString(),
                  style: TextStyle(fontSize: 70),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
                color: Color.fromRGBO(232, 232, 232, 1),
                borderRadius: BorderRadius.circular(40)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: fruitQuerys.getFruitSell(
                        Provider.of<userProvider>(context, listen: false).id,
                        Provider.of<workDayProvider>(context, listen: false)
                            .id),
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
                                  FruitSellCard(
                                    fruit: snapshot.data![i],
                                  ),
                                if (i + 1 < snapshot.data!.length &&
                                    isStartOfRow)
                                  FruitSellCard(
                                    fruit: snapshot.data![i + 1],
                                  ),
                              ],
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
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(232, 232, 232, 1),
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      )),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                              "Total de potes: ${context.watch<fruitProvider>().totalPotes}"),
                          Text(
                              "Dinero generado: ${context.watch<fruitProvider>().totalMoney}"),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            final response = await fruitQuerys.getFruitSell(
                                Provider.of<userProvider>(context,
                                        listen: false)
                                    .id,
                                Provider.of<workDayProvider>(context,
                                        listen: false)
                                    .id);
                            int totalPotes = 0;
                            int totalMoney = 0;
                            response.forEach((element) {
                              totalPotes += int.parse(element.cantidad);
                              totalMoney +=
                                  int.parse(element.cantidad) * element.price;
                            });
                            context
                                .read<fruitProvider>()
                                .setTotalPotes(totalPotes);
                            context
                                .read<fruitProvider>()
                                .setTotalMoney(totalMoney);
                          },
                          child: Icon(Icons.refresh))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
