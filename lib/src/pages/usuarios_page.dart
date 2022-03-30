import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app_lee/src/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController = RefreshController();
  final usuarios = [
    Usuario(uid: '1', nombre: 'Lee', email: 'lee@gmail.com', online: true),
    Usuario(uid: '2', nombre: 'Liz', email: 'liz@gmail.com', online: false),
    Usuario(uid: '3', nombre: 'Yesi', email: 'yesi@gmail.com', online: true),
    Usuario(uid: '4', nombre: 'Flor', email: 'flor@gmail.com', online: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mi nombre',
            style: TextStyle(color: Colors.black54),
          ),
          centerTitle: true,
          elevation: 2,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
              )),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(Icons.online_prediction, color: Colors.blue),
              // child: const Icon(Icons.offline_bolt_sharp, color: Colors.red),
            )
          ],
        ),
        body: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            onRefresh: _cargarUsuarios,
            header: WaterDropHeader(
              complete: Icon(Icons.check, color: Colors.green[400]),
              waterDropColor: Colors.blue,
            ),
            child: _listViewUsuarios()));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, i) => _usuarioListTitle(usuarios[i]),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: usuarios.length);
  }

  ListTile _usuarioListTitle(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  //me creo una funcion
  _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
