import 'package:chat/routes/routes.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        // como el provider esta envolviendo el Material app Todas las rutas van a tener en su context su authservices
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute:
            'loading', //Esta ruta se va a encargar de saber si ya esta autenticado
        routes: appRoutes,
      ),
    );
  }
}
