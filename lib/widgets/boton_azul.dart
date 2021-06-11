//Boton
import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  // const ({ Key? key }) : super(key: key);
  //Variables que voy a utilozar
  final String text;
  final Function onPressed;
  final Color color;
//El constructor de mis variables
  const BotonAzul({
    Key key, //
    @required this.text, //
    @required this.onPressed, //
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color),
// shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0), ), ),//Este ya trai
        shape: MaterialStateProperty.all<StadiumBorder>(StadiumBorder()),
        // elevation: MaterialStateProperty.all(0.0) // este traia
        elevation: MaterialStateProperty.all(2.0),
      ) //
      ,
      onPressed: this.onPressed,
      child: Container(
        width: double.infinity,
        height: 55,
        // padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),

        child: Center(
          child: Text(
            this.text,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
