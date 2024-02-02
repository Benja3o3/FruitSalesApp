import 'package:flutter/material.dart';
import 'package:frontend/widgets/loginForm.dart';
import 'package:frontend/widgets/textEntry.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(199, 199, 199, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 80),
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Image.asset("assets/mainLogo.png")),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Ventas de verano",
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            const LoginForm()
          ],
        ),
      ),
    );
  }
}
