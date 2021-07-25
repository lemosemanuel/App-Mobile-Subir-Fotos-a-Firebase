import 'package:flutter/material.dart';
import 'package:formaulario_y_bloc/src/bloc/provider.dart';
import 'package:formaulario_y_bloc/src/pages/home_page.dart';
import 'package:formaulario_y_bloc/src/pages/registro_page.dart';
import 'package:formaulario_y_bloc/src/pages/login_page.dart';
import 'package:formaulario_y_bloc/src/pages/producto_page.dart';
import 'package:formaulario_y_bloc/src/preferencias_usuario/preferencias_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new Preferencias();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final preferencias = Preferencias();
    print(preferencias.token);
    return Provider(
        child: MaterialApp(
      title: 'Form_Bloc',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'producto': (BuildContext context) => ProductoPage(),
        'registro': (BuildContext context) => Registro(),
      },
      theme: ThemeData(primaryColor: Colors.deepPurple),
    ));
  }
}
