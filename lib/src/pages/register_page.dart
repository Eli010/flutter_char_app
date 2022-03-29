import 'package:chat_app_lee/src/widgets/custom_input.dart';
import 'package:flutter/material.dart';

import '../widgets/boton_personalizado.dart';
import '../widgets/labels.dart';
import '../widgets/logo.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xff11F2E7),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  // ignore: avoid_unnecessary_containers
                  Logo(
                    titulo: 'Register',
                  ),
                  _Form(),
                  Labels(
                    ruta: 'login',
                    titulo: '¿Ya tienes cuenta?',
                    subTitulo: 'Ingrese ahora!',
                  ),
                  Text('Terminos y Condiciones')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final nombreCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          CustomInput(
            hintext: 'Email',
            icon: Icons.email_outlined,
            textEditingController: emailCtrl,
            keyboradType: TextInputType.emailAddress,
          ),
          CustomInput(
            icon: Icons.lock_outline_rounded,
            hintext: 'contraseña',
            textEditingController: passCtrl,
            isPassword: true,
          ),
          CustomInput(
              icon: Icons.person,
              hintext: 'nombre',
              textEditingController: nombreCtrl),
          BotonPersonalizado(
            text: 'Registrar',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
