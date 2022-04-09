import 'package:chat_app_lee/src/global/enviroment.dart';
import 'package:chat_app_lee/src/models/usuario.dart';
import 'package:chat_app_lee/src/models/usuario_response.dart';
import 'package:chat_app_lee/src/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final uri = Uri.parse('${Enviroment.apiUrl}/usuarios');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() as String
      });
      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
