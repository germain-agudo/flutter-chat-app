// import 'dart:ui';
import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';

import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/boton_azul.dart';

class RegisterPage extends StatelessWidget {
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
                  tiutlo: 'Register',
                ),
                _Form(),
                Labels(
                  ruta: 'login',
                  titulo: '¿Ya tienes una cuenta?',
                  subTitulo: 'Ingresa ahora!',
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
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

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
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
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
            text: 'crear cuenta',
            onPressed: (authService.autenticando)
                ? null
                : () async {
                    print(nameCtrl.text);
                    print(emailCtrl.text);
                    print(passCtrl.text);
                    final registroOk = await authService.register(
                        nameCtrl.text.trim(),
                        emailCtrl.text.trim(),
                        passCtrl.text.trim());
                    if (registroOk == true) {
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      mostrarAlerta(context, 'registro incorrecto', registroOk);
                    }
                  },
          )
        ],
      ),
    );
  }
}

// LABELS
