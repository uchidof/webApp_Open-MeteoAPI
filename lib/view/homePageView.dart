import 'package:flutter/material.dart';
import 'package:weather_dashboard/model/weatherModel.dart';
import 'package:weather_dashboard/service/weatherService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<WeatherModel> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = WeatherService().fetchWeather(
      latitude: -23.55,
      longitude: -46.63,
      //SP
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título
              const Text(
                "Clima Atual",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              // FutureBuilder exibindo clima
              FutureBuilder<WeatherModel>(
                future: futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Text("ERRO."); //TODO tratameto de erro
                  }

                  if (!snapshot.hasData) {
                    return const Text("Nenhum dado encontrado.");
                  }

                  final weather = snapshot.data!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Temperatura: ${weather.temp}°C",
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        "Clima: ${weather.description}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        "Horário da medição (local): ${weather.localTime}\nHorário da medição (servidor): ${weather.time}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        "Velocidade do vento: ${weather.windspeed} km/h",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        "Direção do vento: ${weather.winddirection}°",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        "Está de dia?: ${weather.isDay ? "Sim" : "Não"}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        "Intervalo da medição: ${weather.interval} segundos",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 20),

              // Botão será adicionado depois
              // Placeholder
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    futureWeather = WeatherService().fetchWeather(
                      latitude: -23.55,
                      longitude: -46.63,
                      //SP
                    );
                  });
                },
                child: const Text("Atualizar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
