import 'package:flutter/material.dart';
import 'package:frontend/api/auth.dart';
import 'package:frontend/pages/screens/fruitSelectScreen.dart';
import 'package:frontend/pages/workPage.dart';
import 'package:frontend/providers/workDayProvider.dart';
import 'package:frontend/widgets/textEntry.dart';
import 'package:frontend/widgets/userHomeCard.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/userProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Auth auth = Auth();
  final workDayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserHomeCard(username: context.watch<userProvider>().username),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Text(workDayController.text),
            ElevatedButton(
              onPressed: () {
                context.read<workDayProvider>().generateId();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FruitSelectScreen()));
              },
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                    Color.fromRGBO(235, 235, 235, 1)),
                minimumSize: MaterialStatePropertyAll(
                    Size(MediaQuery.of(context).size.width * 0.8, 50)),
                maximumSize: MaterialStatePropertyAll(
                    Size(MediaQuery.of(context).size.width * 0.8, 50)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 40, child: Image.asset("assets/newIcon.png")),
                  Text(
                    "Nuevo dia de trabajo",
                    style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            TextEntry(
                keyboardType: TextInputType.number,
                controller: workDayController,
                placeHolderText: "Ingresa a un nuevo dia",
                isPassword: false),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                  ),
                  onPressed: () {
                    context
                        .read<workDayProvider>()
                        .setId(int.parse(workDayController.text));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WorkPage()));
                  },
                  child: const Text(
                    "Ingresar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
