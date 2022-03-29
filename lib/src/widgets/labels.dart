import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String titulo;
  final String subTitulo;

  const Labels(
      {Key? key,
      required this.ruta,
      required this.titulo,
      required this.subTitulo})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          // ignore: avoid_unnecessary_containers
          Container(
              child: Text(
            titulo,
            style: TextStyle(color: Colors.grey[700]),
          )),
          const SizedBox(
            height: 5,
          ),
          Text(
            subTitulo,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      onTap: () {
        Navigator.pushReplacementNamed(context, ruta);
      },
    );
  }
}
