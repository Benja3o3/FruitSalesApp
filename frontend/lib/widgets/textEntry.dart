import 'package:flutter/material.dart';

class TextEntry extends StatefulWidget {
  final String placeHolderText;
  final bool isPassword;
  final TextEditingController controller;

  const TextEntry(
      {required this.controller,
      required this.placeHolderText,
      required this.isPassword,
      Key? key})
      : super(key: key);

  @override
  _TextEntryState createState() => _TextEntryState();
}

class _TextEntryState extends State<TextEntry> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              controller: widget.controller,
              obscureText: widget.isPassword,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(217, 217, 217, 1),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(88, 88, 88, 1))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(88, 88, 88, 1), width: 2)),
                  hintText: widget.placeHolderText,
                  contentPadding: const EdgeInsets.only(left: 20)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Por favor ingrese un valor valido";
                }
                return null;
              },
            )),
      ],
    );
  }
}
