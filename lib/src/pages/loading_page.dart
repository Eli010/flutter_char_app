import 'package:chat_app_lee/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: checkLoginState(context),
            builder: (context, snapshot) {
              return const Center(
                child: Text('Espere...'),
              );
            }));
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();
    if (autenticado) {
      //TODO:conectar con el socket server
      Navigator.pushReplacementNamed(context, 'usuarios');
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
