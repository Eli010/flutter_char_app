import 'package:chat_app_lee/src/global/enviroment.dart';
import 'package:chat_app_lee/src/models/mensajes_response.dart';
import 'package:chat_app_lee/src/models/usuario.dart';
import 'package:chat_app_lee/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  Usuario? usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final uri = Uri.parse('${Enviroment.apiUrl}/mensajes/$usuarioID');
    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken() as String
    });
    final mensajesResp = mensajesResponseFromJson(resp.body);
    return mensajesResp.mensajes;
  }
}
