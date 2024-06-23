import 'package:shared_preferences/shared_preferences.dart';

class CepStorage {

  static Future<String?> carregarResultadoSalvo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('endereco_salvo');
  }

  static Future<void> salvarResultado(String resultado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('endereco_salvo', resultado);
  }
}
