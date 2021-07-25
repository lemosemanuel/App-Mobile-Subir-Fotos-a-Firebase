import 'dart:convert';

import 'package:formaulario_y_bloc/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

// aca vamos a aplicar toda la logica en cuanto a login y registro Token etc...

class UsuarioProvider {
  // creo el token de firebase
  final String _firebaseToken = ' AIzaSyA7tDaA5iJnfw5RubYxxtbXlbbGxVmTKt8 ';

  // creo las preferencias para guardar el token en el dispositivo
  final _pref = Preferencias();

  // LOGIN
  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
      Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken'),
      body: json.encode(authData),
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    // aca lo que va  pasar es que me va a devolver un token si se crea o un Email ya existe
    if (decodedResp.containsKey('idToken')) {
      // guardar el toquen
      print(decodedResp);

      // guardo el token en prefs (osea en el dispositivo)
      _pref.token = decodedResp['idToken'];

      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      // el mail ya esta
      print(decodedResp);

      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }

  // CREO USUARIO
  // voy a recibir un email y un password y regresa un <Map<String,dynamic>>
  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    //  va a ser un mapa
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
      Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken '),
      body: json.encode(authData),
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    // aca lo que va  pasar es que me va a devolver un token si se crea o un Email ya existe
    if (decodedResp.containsKey('idToken')) {
      // guardar el toquen
      print(decodedResp);

      _pref.token = decodedResp['idToken'];

      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      // el mail ya esta
      print(decodedResp);
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }
}
