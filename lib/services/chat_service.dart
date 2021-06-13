//Provider que notifica a os hijos cuando algo cambie
import 'package:chat/global/environments.dart';
import 'package:chat/models/mensaje_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:chat/models/usuario.dart';

class ChatService with ChangeNotifier {
  Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final uri = Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID');

    final resp = await http.get(uri, headers: {
      'Content-Type': 'Application/json',
      'x-token': await AuthService.getToken()
    });
    final mensajeResp = mensajesResponseFromJson(resp.body);
    return mensajeResp.mensajes;
  }
}
