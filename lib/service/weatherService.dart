import 'dart:convert'; // Para decodificar JSON
import 'package:http/http.dart' as http;
import 'package:weather_dashboard/model/weatherModel.dart';

class WeatherService {
  final String _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<WeatherModel> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    final url = Uri.parse(
      '$_baseUrl?latitude=$latitude&longitude=$longitude&current_weather=true&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max,sunrise,sunset,precipitation_sum&timezone=auto',
    );
    print('[service]: URL formada: ${url}');

    try {
      print('[service]: Chamando API...');
      print("[service]: Chamada feita em: ${DateTime.now()}");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        print('[service]: Dados recebidos! Imprimindo Dados...${json}');

        final weatherNow = WeatherModel.fromJson(json);
        print(
          '[service]: DADOS no objeto! Imprimindo Dados...${weatherNow.writeWeather()}',
        );

        return weatherNow; //Retorno objeto WeatherNow
      } else {
        throw Exception('[service]: Erro na API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('[service]: Erro ao buscar dados: $e');
    }
  }
}
