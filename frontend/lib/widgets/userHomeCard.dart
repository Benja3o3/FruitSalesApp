import 'package:flutter/material.dart';
import 'package:frontend/providers/userProvider.dart';
import 'package:provider/provider.dart';

class UserHomeCard extends StatefulWidget {
  final String username;
  const UserHomeCard({required this.username, Key? key}) : super(key: key);

  @override
  _UserHomeCardState createState() => _UserHomeCardState();
}

class _UserHomeCardState extends State<UserHomeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.12,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(218, 218, 218, 1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            width: 85,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset("assets/profileIcon.png")),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Bienvenido, ",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                  TextSpan(
                    text: widget.username,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Text("¿Que deseas hacer hoy?"),
          ],
        )
      ]),
    );
  }
}
