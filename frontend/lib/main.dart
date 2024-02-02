import 'package:flutter/material.dart';
import 'package:frontend/pages/loginPage.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/userProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => userProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Nunito'),
      home: const LoginPage(),
    );
  }
}
