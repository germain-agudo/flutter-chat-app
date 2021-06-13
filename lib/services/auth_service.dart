import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/environments.dart';

import 'package:chat/models/login_responde.dart';
import 'package:chat/models/usuario.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;

// Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners(); // Notifica a todos los que esten escuhando la propiedad _autemticando para que se redibuje
  }

//Getter del token de forma estática
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

// eliminar token de forma estática
  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

//Este future va a regresar un true si todo sale bien y n false si sale mal
  Future login<bool>(String email, String password) async {
    this.autenticando = true;

    final data = {'email': email, 'password': password};

    ///Convertimos la url
    final uri = Uri.parse('${Environment.apiUrl}/login');

//aremos la peticion
    final resp = await http.post(uri, body: jsonEncode(data), //datos
        headers: {
          //tipo a enviar
          'Content-Type': 'application/json'
        });

//Validar el status
    print(resp.body);

    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      //Guardar Token en lugar seguro
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    this.autenticando = true; // verificar los listeners

    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
    };

    final uri = Uri.parse('${Environment.apiUrl}/login/new');

//haremos la peticion
    final resp = await http.post(uri, body: jsonEncode(data), //datos
        headers: {
          //tipo a enviar
          'Content-Type': 'application/json'
        });

//Validar el status
    print(resp.body);

    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      //Guardar Token en lugar seguro
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');

    final uri = Uri.parse('${Environment.apiUrl}/login/renew');

    final resp = await http.get(uri, headers: {
      //tipo a enviar
      'Content-Type': 'application/json',
      'x-token': token
    });

//Validar el status
    print(resp.body);

    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      //Guardar Token en lugar seguro
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    // Write value
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
