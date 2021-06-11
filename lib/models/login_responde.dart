// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/usuario.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.ok,
    this.usuario,
    this.token,
  });

  bool ok;
  Usuario usuario;
  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        usuario: Usuario.fromJson(json["usuario"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuario.toJson(),
        "token": token,
      };
}

// class Usuario {
//   Usuario({
//     this.online,
//     this.nombre,
//     this.email,
//     this.uid,
//   });

//   bool online;
//   String nombre;
//   String email;
//   String uid;

//   factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
//         online: json["online"],
//         nombre: json["nombre"],
//         email: json["email"],
//         uid: json["uid"],
//       );

//   Map<String, dynamic> toJson() => {
//         "online": online,
//         "nombre": nombre,
//         "email": email,
//         "uid": uid,
//       };
// }
