import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'service/weatherService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'The Weather app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final WeatherService apiservice = WeatherService();

  Map<String, dynamic>? weatherData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  Future<void> loadWeather() async {
    try {
      print('[APP]: Chamando no front...');
      final data = await apiservice.fetchWeather(
        // LOCAL: Sao Paulo
        latitude: -23.55,
        longitude: 46.63,
      );

      setState(() {
        weatherData = data['current_weather'];
        if (weatherData != null) {
          print('[APP]: DADOS ADQUIRIDOS!!');
          print('[APP]: Segue os dados: ${weatherData}');
        }
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  String formatDateString(String isoDate) {
    // Exemplo: 2025-07-09T17:30
    try {
      // Divide data e hora
      final parts = isoDate.split('T');
      if (parts.length != 2) return isoDate;

      final datePart = parts[0]; // "2025-07-09"
      final timePart = parts[1]; // "17:30"

      // Quebra a data
      final dateElements = datePart.split('-');
      if (dateElements.length != 3) return isoDate;

      final year = dateElements[0];
      final month = dateElements[1];
      final day = dateElements[2];

      // Mapa para meses em português
      const meses = {
        '01': 'Janeiro',
        '02': 'Fevereiro',
        '03': 'Março',
        '04': 'Abril',
        '05': 'Maio',
        '06': 'Junho',
        '07': 'Julho',
        '08': 'Agosto',
        '09': 'Setembro',
        '10': 'Outubro',
        '11': 'Novembro',
        '12': 'Dezembro',
      };

      final mesExtenso = meses[month] ?? month;

      return '$day de $mesExtenso de $year á partir das $timePart';
    } catch (e) {
      return isoDate; // retorna original se der erro
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Weather Dashboard',
          style: TextStyle(color: Colors.white), // Cor do texto
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) // 👈 Se está carregando, mostra o spinner
              const CircularProgressIndicator()
            else if (weatherData != null) // 👈 Se já tem dados
              Column(
                children: [
                  const Text(
                    '🌤️ Dados do Clima:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '⏱️ Última atualização: ${formatDateString(weatherData?['time'])}',
                  ),

                  const Divider(),
                  const Text(
                    '📊 Dados atuais:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('🌡️ Temperatura: ${weatherData?['temperature']}°C'),
                  Text('🌬️ Vento: ${weatherData?['windspeed']} km/h'),
                  Text(
                    '🧭 Direção do vento: ${weatherData?['winddirection']}°',
                  ),
                  Text(
                    '🌙 Dia ou Noite: ${weatherData?['is_day'] == 1 ? 'Dia' : 'Noite'}',
                  ),
                ],
              )
            else // 👈 Caso não tenha nada carregado
              const Text(
                'Nenhum dado carregado!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true; // 🌀 Ativa o loading ao clicar
                });
                loadWeather();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: const Text('Recarregar Clima'),
            ),
          ],
        ),
      ),
    );
  }
}
