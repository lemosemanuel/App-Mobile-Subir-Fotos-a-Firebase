import 'package:shared_preferences/shared_preferences.dart';

const String COLORKEY = "color";
const String GENDERKEY = "gender";
const String NAMEKEY = "name";

class Preferencias {
  static final Preferencias _instancia = new Preferencias._internal();

  factory Preferencias() {
    return _instancia;
  }

  Preferencias._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Pos hemos llegado xdd");
    this._prefs = prefs;
    print("Pos hemos llegado xdd");
  }

  // GET y SET del nombreUsuario
  String get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // GET y SET de la última página
  String get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'home';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }
}
