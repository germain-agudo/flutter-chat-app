//Para identificar los mensajes mios y los de otras personas

import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  // const ChatMessage({ Key? key }) : super(key: key);
  final String texto;
  final String uid;

  final AnimationController animationController;

  const ChatMessage({
    //
    Key key,
    @required this.texto,
    @required this.uid, //
    @required this.animationController, //controlar una a animación
  }) : super(key: key);

  /// si es igual al mio el uid es que es mio y si no de otro

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      // El encargado de hacer la animacion
      opacity: animationController,
      child: SizeTransition(
        // ayuda a transformar el tamaño del widget
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: this.uid == '123' ? _myMessage() : _notMyMessage(),
        ),
      ),
    );
  }

// Mis mensajes
  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight, // Alinearlo al lado derecho
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(
            //La separacion
            right: 5,
            bottom: 5,
            left: 50),
        child: Text(this.texto, style: TextStyle(color: Colors.white)),
        decoration: BoxDecoration(
            color: Color(0xff4D9EF6), borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

// Los de Otros
  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft, // Alinearlo al lado derecho
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(
            //La separacion
            left: 5,
            bottom: 5,
            right: 50),
        child: Text(this.texto, style: TextStyle(color: Colors.black87)),
        decoration: BoxDecoration(
            color: Color(0xffE4E5E8), borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
