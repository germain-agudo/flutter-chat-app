// import 'dart:ui';
import 'package:chat/widgets/boton_azul.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';

import 'package:chat/helpers/mostrar_alerta.dart';

import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/custom_input.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 650,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Logo(
                  tiutlo: 'Messenger',
                ),
                _Form(),
                Labels(
                  ruta: 'register',
                  titulo: '¿No tienes cuenta?',
                  subTitulo: 'Crea una ahora!',
                ),
                Text(
                  'Terminos y condiciones de uso',
                  style: TextStyle(fontWeight: FontWeight.w200),
                )
              ],
            ),
          ),
        ));

/*     Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          //El safeArea es un Widget que nos va a ayudar para daber si tiene un notch que nos estorve, y asi bajarlo un poco
          child: SingleChildScrollView(
            // Para que podamos hacer scroll
            physics:
                BouncingScrollPhysics(), //Para que se vea el efecto como si revotara al hacer scroll
            child: Container(
              // este container es para que mi contenido no quede apretado
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, //Para que mi contenido se disperse por toda la pantalla
                children: <Widget>[
                  Logo(),
                  _Form(),
                  Labels(),
                  Text(
                    'Términos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        )); */
  }
}

// LOGO

// FORMULARIO
class _Form extends StatefulWidget {
  // _Form({Key key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
//el listen en false para que provider no intente redibujar el widget y yo no necesito
//
    final authService = Provider.of<AuthService>(context, listen: true);

    return Container(
      margin: EdgeInsets.only(top: 40), //Margen o espacio hacia abajo
      padding: EdgeInsets.symmetric(
          horizontal:
              50), // el espacio de los lados del contenedor de mis inputs
      child: Column(
        children: <Widget>[
          ///Aqui llamammos a nuestro widget que creamos en custom inout
          CustomInput(
            // Correo
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            // Password
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            // keyboardType: TextInputType.emailAddress,
            textController: passCtrl,
            isPassword: true,
          ),

          // Todo: Crear boton
          BotonAzul(
            //
            color: (authService.autenticando) ? Colors.blueGrey : Colors.blue,
            text: 'Ingrese',
            onPressed: (authService.autenticando)
                ? null
                : () async {
// el listen en false para que provider no intente redibujar el widget y yo no necesito
// final authService = Provider.of<AuthService>(context, listen: true);
                    // print(emailCtrl.text);
                    // print(passCtrl.text);
                    FocusScope.of(context)
                        .unfocus(); // va a quitar el focus es decir el tecado
                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());
                    if (loginOk) {
                      //tODO:Navegar a otra pantalla
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      //Mostrar Alerta
                      mostrarAlerta(context, 'Login incorrecto',
                          'Revise sus credenciales nuevamente');
                    }
                  },
          )
        ],
      ),
    );
  }
}

// LABELS
