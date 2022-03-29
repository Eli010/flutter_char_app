import 'package:chat_app_lee/src/pages/chat_pages.dart';
import 'package:chat_app_lee/src/pages/loading_page.dart';
import 'package:chat_app_lee/src/pages/login_page.dart';
import 'package:chat_app_lee/src/pages/register_page.dart';
import 'package:chat_app_lee/src/pages/usuarios_page.dart';
import 'package:flutter/material.dart';

// abstract class Pages {
//   static Map<String, Widget Function(BuildContext)> appRoutes = {
//     'login': (BuildContext context) => const LoginPage(),
//   };
// }
Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    'loading': (_) => const LoadingPage(),
    'login': (_) => const LoginPage(),
    'register': (_) => const RegisterPage(),
    'usuarios': (_) => const UsuariosPage(),
    'chat': (_) => const ChatPage()
  };
}
