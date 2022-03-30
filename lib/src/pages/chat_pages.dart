import 'dart:io';

import 'package:chat_app_lee/src/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  bool _estaEscribiendo = false;

  final List<ChatMessage> _message = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              CircleAvatar(
                child: const Text(
                  'Le',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                backgroundColor: Colors.blue[100],
                maxRadius: 14,
              ),
              const SizedBox(
                height: 3,
              ),
              const Text(
                'Lee Pacombia',
                style: TextStyle(color: Colors.black, fontSize: 13),
              )
            ],
          ),
          centerTitle: true,
          elevation: 1,
        ),
        body: Column(
          children: [
            Flexible(
                child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _message.length,
              itemBuilder: (_, i) => _message[i],
              reverse: true,
            )),
            const Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              // height: 100,
              child: _inputChat(),
            )
          ],
        ));
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Flexible(
                child: TextField(
              controller: _textController,
              onSubmitted: _handledSubmit,
              onChanged: (String texto) {
                //?preguntamos is tiene algo escrito en le textfield
                setState(() {
                  // ignore: prefer_is_empty
                  if (texto.trim().length > 0) {
                    _estaEscribiendo = true;
                  } else {
                    _estaEscribiendo = false;
                  }
                });
              },
              decoration:
                  const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
              focusNode: _focusNode,
            )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: const Text('Enviar'),
                      onPressed: _estaEscribiendo
                          ? () => _handledSubmit(_textController.text.trim())
                          : null)
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue[400]),
                        child: IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: _estaEscribiendo
                                ? () =>
                                    _handledSubmit(_textController.text.trim())
                                : null),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  _handledSubmit(String texto) {
    if (texto.isEmpty) return;
    // ignore: avoid_print
    print(texto);
    _textController.clear();
    _focusNode.requestFocus();
    final newMessage = ChatMessage(
      texto: texto,
      uid: '123',
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
    );
    _message.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    //TODO: off del socket
    for (ChatMessage message in _message) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
