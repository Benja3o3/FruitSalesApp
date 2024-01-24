import 'package:flutter/material.dart';
import 'package:fruit_sales_app/mapScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fruit_sales_app/fruitCard.dart';
import 'package:fruit_sales_app/informationCard.dart';
import 'package:fruit_sales_app/restartPopup.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.amber,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.map), label: "Map")
          ],
        ),
        appBar: AppBar(
          title: const Text("Ventas"),
          actions: [
            ElevatedButton(
                onPressed: () => _showPopup(context),
                child: Icon(Icons.restart_alt)),
            ElevatedButton(onPressed: () {}, child: Icon(Icons.upload))
          ],
        ),
        body: <Widget>[
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Column(
                  children: [
                    const Text(
                      "Frutas Vendidas",
                      style: TextStyle(fontSize: 30),
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
                        decoration: InputDecoration(labelText: "Vuelto: "),
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
                  "Plata que se debe entregar = ${totalSells - vuelto - ctaRut}",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          MapScreen()
        ][currentPageIndex]);
  }
}
