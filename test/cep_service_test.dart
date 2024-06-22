import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_cep_pk/my_cep_pk.dart'; // Substitua pelo caminho correto do seu código fonte

class MockClient extends Mock implements http.Client {}

void main() {
  group('CepService', () {

    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('salvarResultado salva o endereço corretamente', () async {
      const resultado = 'Endereço: Praça da Sé, Sé, São Paulo, SP';

      await CepService.salvarResultado(resultado);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('endereco_salvo'), resultado);
    });

    test('carregarResultadoSalvo carrega o endereço salvo corretamente', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('endereco_salvo', 'Endereço salvo');

      final resultado = await CepService.carregarResultadoSalvo();
      expect(resultado, 'Endereço salvo');
    });
  });
}
