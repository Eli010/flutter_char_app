// ARHIVO PARA ENVIAR PURTOS Y SABER SI ES ANDOIRD O IOS

import 'dart:io';

class Enviroment {
  //uso de url an caso de que sea andoid o ios
  static String apiUrl = Platform.isAndroid
      ? 'http://10.0.2.2:3000/api'
      : 'http://localhost:3000/api';

  //url para el uso del socket io
  static String socketUrl =
      Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';
}
