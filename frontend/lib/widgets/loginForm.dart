// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:frontend/api/auth.dart';
import 'package:frontend/models/token.dart';
import 'package:frontend/pages/homePage.dart';
import 'package:frontend/widgets/textEntry.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/userProvider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String errorMessage = "";
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final dio = Dio();
  late Token token = Token(token: "");
  final Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextEntry(
              keyboardType: TextInputType.text,
              controller: usernameController,
              placeHolderText: "Nombre de usuario",
              isPassword: false,
            ),
            const SizedBox(
              height: 30,
            ),
            TextEntry(
              keyboardType: TextInputType.text,
              controller: passwordController,
              placeHolderText: "***********",
              isPassword: true,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorMessage,
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                ),
                onPressed: () async {
                  final tokenResponse;
                  try {
                    tokenResponse = await auth.getToken(
                        usernameController.text, passwordController.text);
                  } catch (e) {
                    setState(() {
                      errorMessage = "Usuario o contraseña incorrectos";
                    });
                    return;
                  }
                  final profileResponse =
                      await auth.getProfile(tokenResponse.token);
                  context.read<userProvider>().setToken(tokenResponse.token);
                  context
                      .read<userProvider>()
                      .setUsername(profileResponse.username);
                  context.read<userProvider>().setType(profileResponse.type);
                  context.read<userProvider>().setId(profileResponse.id);
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false);
                  }
                },
                child: const Text(
                  "Iniciar",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          ],
        ));
  }
}
