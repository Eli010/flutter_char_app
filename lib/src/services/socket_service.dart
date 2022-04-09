// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:chat_app_lee/src/global/enviroment.dart';
import 'package:chat_app_lee/src/services/auth_service.dart';

enum ServerStatus {
  Online,
  Ofline,
  Connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;
  //realizamos una peticion get par ausar fuera de nuestro archivo
  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket;

  Function get emit => _socket.emit;

  void connect() async {
    //asignamos un token
    final token = await AuthService.getToken();
    _socket = IO.io(
        Enviroment.socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            //definicno nuestra cabecera
            .setExtraHeaders({'x-token': token})
            .build());
    _socket.onConnect((_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.Ofline;
      notifyListeners();
    });
  }

  void disconnect() {
    _socket.disconnect();
  }
}
