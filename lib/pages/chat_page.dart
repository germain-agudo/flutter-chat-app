import 'dart:io';

import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

//Aqui mesclamos el state con el tiket
class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  // para trabajar con las aimaciones
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  bool _estaEscribiendo = false;

  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: <Widget>[
            CircleAvatar(
              child: Text(
                'Te',
                style: TextStyle(fontSize: 12),
              ), //
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Melissa Flores',
              style: TextStyle(color: Colors.black87, fontSize: 12),
            )
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_, i) =>
                  _messages[i], //ESto lo creamos en un widget
              reverse: true,

              ///este es para que mande los datos de abajo hacia arriba desc
            ) //

                ),
            Divider(
              height: 1,
            ),
            //todo: Caja de texto
            Container(
              color: Colors.white,
              // height: 50,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted:
                  _handleSubmit, //cuando se haga un submit de este campo ,un posteo
              onChanged: (texto) {
                //El texto actual
                // todo: cuando hay un valor, para poder postear
                setState(() {
                  if (texto.trim().length > 0) {
                    _estaEscribiendo = true;
                  } else {
                    _estaEscribiendo = false;
                  }
                });
              },
              decoration: InputDecoration.collapsed(
                  //Para que desaparesca la linea
                  hintText: 'Enviar mensaje'),
              focusNode: _focusNode,
            ),
          ),

          //Boton enviar
          Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: (Platform.isIOS)
                  ? CupertinoButton(
                      //Para IOS
                      child: Text('Enviar'),
                      onPressed: (_estaEscribiendo) //
                          ? () => _handleSubmit(_textController.text.trim())
                          : null,
                    )
                  : Container(
                      //Para android
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue[400]),
                        child: IconButton(
                          highlightColor:
                              Colors.transparent, //el color del efecto
                          splashColor: Colors.transparent,
                          icon: Icon(
                            Icons.send,
                          ),
                          onPressed: (_estaEscribiendo) //
                              ? () => _handleSubmit(_textController.text.trim())
                              : null,
                        ),
                      ),
                    ))
        ],
      ),
    ));
  }

//Obtener la informacion a enviar
  _handleSubmit(String texto) {
    if (texto.length == 0) return;

    print(texto);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      uid: '123',
      texto: texto,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage); //se hace la isnercion
    newMessage.animationController.forward();

    ///aqui empieza la aimacion
    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    // tODO: off del docket
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
