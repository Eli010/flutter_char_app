import 'package:chat_app_lee/src/services/auth_service.dart';
import 'package:chat_app_lee/src/services/chat_service.dart';
import 'package:chat_app_lee/src/services/socket_service.dart';
import 'package:chat_app_lee/src/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app_lee/src/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController = RefreshController();
  final usuarioService = UsuarioService();
  List<Usuario> usuarios = [];

  @override
  void initState() {
    _cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //importando los provider
    final socketService = Provider.of<SocketService>(context);
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            usuario?.nombre ?? 'Sin Nombre',
            style: const TextStyle(color: Colors.black54),
          ),
          centerTitle: true,
          elevation: 2,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                //desconectando del socket
                socketService.disconnect();
                Navigator.pushReplacementNamed(context, 'login');
                AuthService.deleteToken();
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
              )),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: (socketService.serverStatus == ServerStatus.Online)
                  ? const Icon(Icons.online_prediction, color: Colors.green)
                  : const Icon(Icons.offline_bolt_sharp, color: Colors.red),
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
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = usuario;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  //me creo una funcion
  _cargarUsuarios() async {
    usuarios = await usuarioService.getUsuarios();
    // monitor network fetch
    // await Future.delayed(const Duration(milliseconds: 1000));
    // final UsuarioService = await usuarioService.getUsuarios();

    setState(() {});
    _refreshController.refreshCompleted();
    // if failed,use refreshFailed()
  }
}
