import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
//agrumentos que vamos a nececitar

  final IconData icon; // El icono de mis campos
  final String placeholder; //Lo que va a venir dentro de nuestro input
  final TextEditingController
      textController; // Nos va a ayudar con el manejo de informacion que vienen en nuestros inputs
  final TextInputType keyboardType; //el tipo de teclado que va a venir
  final bool isPassword;

  const CustomInput(
      {Key key, //
      @required this.icon, // el @required es para indicar que es requerido
      @required this.placeholder, //
      @required this.textController, //
      this.keyboardType =
          TextInputType.text, // estos se les asiga un valor por defecto
      this.isPassword = false //
      })
      : super(key: key);

//una ves teniendo todas mis variables marca un error asi que vamos a construir un constructor

  // const CustomInput({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 5,
          left: 5,
          bottom: 5,
          right: 20), //Esto es para que no se pegue al finalde mi margen

      margin: EdgeInsets.only(bottom: 20), //para hacer una separacion
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05), // color con opacidad,
                offset: Offset(0, 5), //Para la direccion se la sombra
                blurRadius: 5)
          ]),
      child: TextField(
        controller: this.textController,
        autocorrect: false,
        keyboardType: this.keyboardType, //Va a ser de tipo de correo
        obscureText: this.isPassword,
        decoration: InputDecoration(
            prefixIcon: Icon(this.icon),
            focusedBorder: InputBorder.none, // este
            border: InputBorder.none, // y este para quitar la linea
            hintText: this.placeholder),
      ),
    );
  }
}
