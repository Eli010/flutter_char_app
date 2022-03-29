import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String hintext;
  final TextEditingController textEditingController;
  final TextInputType keyboradType;
  final bool isPassword;

  const CustomInput(
      {Key? key,
      required this.icon,
      required this.hintext,
      required this.textEditingController,
      this.keyboradType = TextInputType.text,
      this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.transparent.withOpacity(0.05),
                  offset: const Offset(0, 5))
            ]),
        child: TextField(
          autocorrect: false,
          keyboardType: keyboradType,
          controller: textEditingController,
          obscureText: isPassword,
          decoration: InputDecoration(
              // prefixIcon: Icon(Icons.email_outlined),
              prefixIcon: Icon(icon),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: hintext),
        ));
  }
}
