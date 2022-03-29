import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String titulo;

  const Logo({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
              width: 200, child: Image.asset('assets/img/deliveryGirls.png')),
          const SizedBox(
            height: 20,
          ),
          Text(
            titulo,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ],
      ),
    );
  }
}
