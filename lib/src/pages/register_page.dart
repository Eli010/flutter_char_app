// ignore_for_file: avoid_print

import 'package:chat_app_lee/src/helpers/mostrar_alerta.dart';
import 'package:chat_app_lee/src/services/auth_service.dart';
import 'package:chat_app_lee/src/services/socket_service.dart';
import 'package:chat_app_lee/src/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final socketService = Provider.of<SocketService>(context);
    final authService = Provider.of<AuthService>(context);
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
            onPressed: authService.autenticando
                ? () => {}
                : () async {
                    FocusScope.of(context).unfocus();
                    final registerOk = await authService.register(
                        nombreCtrl.text.trim(),
                        emailCtrl.text.trim(),
                        passCtrl.text.trim());
                    if (registerOk == true) {
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      mostrarAlerta(context, 'Registro Incorrecto',
                          'Todos los campos son obligatorios');
                    }
                  },
          ),
        ],
      ),
    );
  }
}
