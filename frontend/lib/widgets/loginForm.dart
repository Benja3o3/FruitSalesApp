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
              controller: usernameController,
              placeHolderText: "Nombre de usuario",
              isPassword: false,
            ),
            const SizedBox(
              height: 30,
            ),
            TextEntry(
              controller: passwordController,
              placeHolderText: "***********",
              isPassword: true,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                ),
                onPressed: () async {
                  final tokenResponse = await auth.getToken();
                  final profileResponse =
                      await auth.getProfile(tokenResponse.token);
                  context.read<userProvider>().setToken(tokenResponse.token);
                  context
                      .read<userProvider>()
                      .setUsername(profileResponse.username);
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                  }
                },
                child: const Text(
                  "Iniciar",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
            Text(token.token)
          ],
        ));
  }
}
