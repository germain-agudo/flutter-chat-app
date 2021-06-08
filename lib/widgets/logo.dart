import 'package:flutter/material.dart';
//Logo

class Logo extends StatelessWidget {
  // const _logo({ Key? key }) : super(key: key);
  final String tiutlo;

  const Logo({Key key, @required this.tiutlo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        //
        margin: EdgeInsets.only(top: 50),

        //El contenido va a estar restringido con el
        width: 170,
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage('assets/tag-logo.png'),
            ),
            Text(
              this.tiutlo,
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
