import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  //Generar la isntancia
  static late SharedPreferences _prefs;
  //Inicializar las preferencias
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get token {
    return _prefs.getString('token') ?? 'Login';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }
}
