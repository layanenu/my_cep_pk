import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CepService {
  final http.Client client;

  CepService({http.Client? client}) : client = client ?? http.Client();

  static Future<String?> carregarResultadoSalvo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('endereco_salvo');
  }

  static Future<void> salvarResultado(String resultado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('endereco_salvo', resultado);
  }

  Future<String> pesquisarCep(String cep) async {
    var url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['erro'] == null) {
        String endereco =
            'Endereço: ${data['logradouro']}, ${data['bairro']}, ${data['localidade']}, ${data['uf']}';
        await salvarResultado(endereco);
        return endereco;
      } else {
        return 'CEP não encontrado.';
      }
    } else {
      return 'Erro na consulta. Tente novamente.';
    }
  }
}
