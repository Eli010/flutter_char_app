import 'package:flutter/material.dart';

class BotonPersonalizado extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const BotonPersonalizado(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 300,
      margin: const EdgeInsets.symmetric(vertical: 15),
      // color: Colors.blue,
      child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(2),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  const StadiumBorder())),
          onPressed: onPressed,
          child: SizedBox(
              height: 50,
              width: double.infinity,
              child: Center(
                  child: Text(
                text,
                style: const TextStyle(fontSize: 18),
              )))),
    );
  }
}
