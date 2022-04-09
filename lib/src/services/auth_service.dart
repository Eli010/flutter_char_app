//CONEXION CON NUESTRA DB

// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import 'package:chat_app_lee/src/global/enviroment.dart';
import 'package:chat_app_lee/src/models/login_response.dart';
import 'package:chat_app_lee/src/models/usuario.dart';

class AuthService with ChangeNotifier {
  Usuario? usuario;

  //la variable bool
  bool _autenticado = false;

  //nos creamo un storage
  final _storage = const FlutterSecureStorage();

  //obtenemos el dato del _autenticado
  bool get autenticando => _autenticado;

  //le asignamos el valor de nuestro valor al _autenticando
  set autenticando(bool valor) {
    _autenticado = valor;
    //con esto hacemos que escuches todos sobre el cambio
    notifyListeners();
  }

  //Getter del token  de forma estatica
  static Future<String?> getToken() async {
    const _storage = FlutterSecureStorage();

    final token = await _storage.read(key: 'token');
    return token;
  }

  //eliminamos nestro token
  static Future<void> deleteToken() async {
    const _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  //OBTENEMOS DATOS DE NUESTRO DB PARA EL LOGIN
  Future<bool> login(String email, String password) async {
    //le mencionamos que autenticando esta true
    autenticando = true;

    //creamos nuestra data
    final data = {'email': email, 'password': password};

    //realizamos la llamada de nuestras ruta
    final uri = Uri.parse('${Enviroment.apiUrl}/login');
    final resp = await http.post(uri,

        //almacenamos el dato
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'});

    //obtenemos todos nuestro datos desde la DB
    print(resp.body);
    autenticando = false;
    //comprobamos si todo sale correctamente
    if (resp.statusCode == 200) {
      //aqui asignamos todo el valor de nuestra base de datos segun nuestor models
      final loginResponse = loginResponseFromJson(resp.body);

      //asignamos solo el valor que obtiene nuestro usuario
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  //AQUI INICIAMOS CON NUESTRO REGISTRO

  Future register(String nombre, String email, String password) async {
    //mencionamos que si esta autenticado
    autenticando = true;

    //mencionamso cuando son los datos que obtendremos y a quien le asignaremos
    final data = {'nombre': nombre, 'email': email, 'password': password};

    //LLAMADA A NUESTRA RUTA
    //parseamos nuestra url
    final uri = Uri.parse('${Enviroment.apiUrl}/login/new');

    final resp = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    print(resp.body);
    autenticando = false;
    if (resp.statusCode == 200) {
      //aqui asignamos todo el valor de nuestra base de datos segun nuestor models
      final loginResponse = loginResponseFromJson(resp.body);

      //asignamos solo el valor que obtiene nuestro usuario
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  //MANTENER LA PANTALLA
  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token') ?? '';
    final uri = Uri.parse('${Enviroment.apiUrl}/login/renew');
    final resp = await http.get(uri,
        headers: {'Content-type': 'application/json', 'x-token': token});
    print(resp.body);
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      //aññadimos solo lo que contiene mi loginResponse.usuario
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  //AQUI GUARDAREMOS NUESTRO JWT
  Future _guardarToken(String token) async {
    // escribimos nuestro valor
    return await _storage.write(key: 'token', value: token);
  }

  //AQUI SALIMOS DE NUESTRO TOKEN
  Future logout() async {
    //eliminamos el valor
    await _storage.delete(key: 'token');
  }
}
