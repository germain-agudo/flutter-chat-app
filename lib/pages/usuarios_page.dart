import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
// Para el pushtorefresh
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  //Lista
  final usuarios = [
    Usuario(uid: '1', nombre: 'María', email: 'test1@test.com', online: true),
    Usuario(
        uid: '2', nombre: 'Melissa', email: 'test2@test.com', online: false),
    Usuario(uid: '3', nombre: 'Germain', email: 'test3@test.com', online: true),
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            usuario.nombre,
            style: TextStyle(color: Colors.black87),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.exit_to_app_sharp,
                color: Colors.black87,
              ), //
              onPressed: () {
                //TODO: desconectarnos del socketSErver
                Navigator.pushReplacementNamed(context, 'login');
                AuthService.deleteToken();
              }),
          //
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue[400],
              ),

              // Icon( Icons.check_circle, color: Colors.red,     ),
            )
          ],
        ),
        body: SmartRefresher(
          // este vamos a utilizar par el pulltorefresh
          controller:
              _refreshController, //El que importamos para el pullto refresh
          enablePullDown:
              true, // este es paraque haga pull con scroll hacia abajo
          onRefresh: _cargarUsuarios, // lo que espera a que cargue
          header: WaterDropHeader(
            // esto es para indicara lo que se mostrara cuando se haga scroll abajo

            complete: Icon(
              Icons.check, //lo que se mostrara cuando cargue el refesh
              color: Colors.blue[400],
            ), //Para el icono
            waterDropColor: Colors.blue[400], //Para el color de la gota de agua
          ),

          child: _listViewUsuarios(),
        ));
  }

//El Listview
  ListView _listViewUsuarios() {
    return ListView.separated(
        physics:
            BouncingScrollPhysics(), //Para dar un efecto cuando se haga scroll,
        itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
        separatorBuilder: (_, i) => Divider(),
        itemCount: usuarios.length);
  }

//El contenido de mi Listview
  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      //va a mostrar los usuarios
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        // lo del lado izquierdo
        child: Text(usuario.nombre.substring(0, 2)), //cortar nombre
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        // lo del lado derecho
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: (usuario.online)
                ? Colors.green
                : Colors.red, // condicion online
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(Duration(
        milliseconds: 1000)); //espera un segundo y sigue con lo de abajo
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
