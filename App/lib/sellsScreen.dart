import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fruit_sales_app/fruitCard.dart';
import 'package:fruit_sales_app/informationCard.dart';
import 'package:fruit_sales_app/restartPopup.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';

class SellsScreen extends StatefulWidget {
  const SellsScreen({Key? key}) : super(key: key);

  @override
  _SellsScreenState createState() => _SellsScreenState();
}

class _SellsScreenState extends State<SellsScreen> {
  final dio = Dio();
  NumberFormat formatoDinero =
      NumberFormat.currency(locale: 'es_CL', symbol: '\$');
  final TextEditingController _vueltoController = TextEditingController();
  final TextEditingController _ctaRutController = TextEditingController();
  List<String> fruits = ["Frambuesas", "Frutillas", "Arándanos", "Cerezas"];
  List<int> fruitCount = [0, 0, 0, 0];
  List<int> fruitPrices = [3000, 2000, 2500, 2000];
  List<int> fruitSells = [0, 0, 0, 0];
  int totalSells = 0;
  int totalMoney = 0;
  int vuelto = 0;
  int ctaRut = 0;

  int frambuesas = 0;
  int currentPageIndex = 0;
  int frutillas = 0;
  String apiResponse = "Frutas vendidas";

  Future<void> getApi() async {
    print("AAAAA");
    try {
      final response = await dio.get("http://10.0.2.2:8000/sessions");
      print("RESPUIESTA");
      setState(() {
        apiResponse = response.data.toString();
      });
    } catch (e) {
      print(e);
      print("ERROR");
    }
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reiniciar ventas'),
          content: const RestartPopup(),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el popup
              },
              child: Text('Cerrar'),
            ),
            TextButton(
              onPressed: () {
                restartSells();
                Navigator.of(context).pop();
              },
              child: Text("Reiniciar"),
            )
          ],
        );
      },
    );
  }

  void increment(int indexFruit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fruitCount[indexFruit]++;
      fruitSells[indexFruit] = fruitCount[indexFruit] * fruitPrices[indexFruit];
      totalSells = fruitSells.reduce((value, element) => value + element);
      totalMoney = fruitSells.reduce((value, element) => value + element);
    });
    prefs.setInt(fruits[indexFruit], fruitCount[indexFruit]);
    prefs.setInt("${fruits[indexFruit]}Sell", fruitSells[indexFruit]);
    prefs.setInt("totalSell", totalSells);
    prefs.setInt("totalMoney", totalMoney);
    getApi();
  }

  void restartSells() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < fruits.length; i++) {
        fruitCount[i] = 0;
        fruitSells[i] = 0;
        prefs.setInt(fruits[i], fruitCount[i]);
        prefs.setInt("${fruits[i]}Sell", fruitSells[i]);
      }
      totalSells = 0;
      totalMoney = 0;
      prefs.setInt("totalSell", totalSells);
      prefs.setInt("totalMoney", totalMoney);
    });
  }

  void decrement(int indexFruit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fruitCount[indexFruit]--;
      if (fruitCount[indexFruit] < 0) fruitCount[indexFruit] = 0;
      fruitSells[indexFruit] = fruitCount[indexFruit] * fruitPrices[indexFruit];
      totalSells = fruitSells.reduce((value, element) => value + element);
      totalMoney = fruitSells.reduce((value, element) => value + element);
    });
    prefs.setInt(fruits[indexFruit], fruitCount[indexFruit]);
    prefs.setInt("${fruits[indexFruit]}Sell", fruitSells[indexFruit]);
    prefs.setInt("totalSell", totalSells);
    prefs.setInt("totalMoney", totalMoney);
  }

  _loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < fruits.length; i++) {
        fruitCount[i] = prefs.getInt(fruits[i]) ?? 0;
        fruitSells[i] = prefs.getInt("${fruits[i]}Sell") ?? 0;
      }
      totalSells = prefs.getInt("totalSell") ?? 0;
      totalMoney = prefs.getInt("totalMoney") ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    getApi();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    apiResponse,
                    style: TextStyle(fontSize: 30),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () => _showPopup(context),
                          child: Icon(Icons.restart_alt)),
                      ElevatedButton(
                          onPressed: () => print("upload"),
                          child: Icon(Icons.upload)),
                    ],
                  ),
                ],
              ),
              for (int i = 0; i < fruits.length; i++)
                FruitCard(
                  fruitName: fruits[i],
                  fruitCount: fruitCount[i],
                  incrementCount: () => increment(i),
                  decrementCount: () => decrement(i),
                ),
            ],
          ),
          InformationCard(
            fruitCounts: fruitCount,
            fruitList: fruits,
            fruitSells: fruitSells,
            totalSells: totalSells,
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                margin: const EdgeInsets.all(5),
                child: TextField(
                  controller: _vueltoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Vuelto: "),
                  onChanged: (value) {
                    setState(() {
                      vuelto = int.parse(value);
                    });
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                margin: const EdgeInsets.all(5),
                child: TextField(
                  controller: _ctaRutController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "En Cta Rut: "),
                  onChanged: (value) {
                    setState(() {
                      ctaRut = int.parse(value);
                    });
                  },
                ),
              )
            ],
          ),
          Text(
            "Plata que se debe entregar = ${formatoDinero.format(totalSells - vuelto - ctaRut)}",
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}
