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
  final _formKey = GlobalKey<FormState>();
  final dio = Dio();
  late Token token = Token(token: "");
  final Auth auth = Auth();
  // var token = {};

  // Future<void> _login() async {
  //   auth.getToken();
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const TextEntry(
              placeHolderText: "Nombre de usuario",
              isPassword: false,
            ),
            const SizedBox(
              height: 30,
            ),
            const TextEntry(
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
                  final response = await auth.getToken();
                  context.read<userProvider>().setToken(response.token);
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
