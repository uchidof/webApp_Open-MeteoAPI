import 'dart:convert'; // Para decodificar JSON
import 'package:http/http.dart' as http;
import 'package:weather_dashboard/model/weatherNow.dart';

class WeatherService {
  final String _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<WeatherNow> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    final url = Uri.parse(
      '$_baseUrl?latitude=$latitude&longitude=$longitude&current_weather=true',
    );
    print('[APP]: URL formada: ${url}');

    try {
      print('[APP]: Chamando API...');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        print('[APP]: Dados recebidos!\nDADOS:\n${json}');

        final weatherNow = WeatherNow.fromJson(json);
        return weatherNow; //Retorno objeto WeatherNow
      } else {
        throw Exception('Erro na API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar dados: $e');
    }
  }
}
