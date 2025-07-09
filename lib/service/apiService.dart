import 'dart:convert'; // Para decodificar JSON
import 'package:http/http.dart' as http;

class Apiservice {
  final String _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<Map<String, dynamic>> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    final url = Uri.parse(
      '$_baseUrl?latitude=$latitude&longitude=$longitude&current_weather=true',
    );
    print('[APP]: URL formada: ${url}');

    try {
      final response = await http.get(url);
      print('[APP]: Chamando API...');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('[APP]: Dados recebidos!');
        print('DADOS:\n${data}');

        return data; //Retorno do JSON
      } else {
        throw Exception('Erro na API: ${response.statusCode}');
        print('[APP]: Erro na API.');
      }
    } catch (e) {
      throw Exception('Erro ao buscar dados: $e');
      print('[APP]: ao buscar dados.');
    }
  }
}
