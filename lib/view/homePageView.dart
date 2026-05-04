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
  bool isRetrying = false;

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
                  // Reset seguro do isRetrying quando o Future terminar
                  if (snapshot.connectionState == ConnectionState.done &&
                      isRetrying) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        isRetrying = false;
                      });
                    });
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.warning),
                              SizedBox(width: 8),
                              Text("Não foi possível carregar os dados"),
                            ],
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: isRetrying
                                ? null
                                : () {
                                    setState(() {
                                      isRetrying = true;
                                      futureWeather = WeatherService()
                                          .fetchWeather(
                                            latitude: -23.55,
                                            longitude: -46.63,
                                          );
                                    });
                                  },
                            child: isRetrying
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text("Carregando..."),
                                    ],
                                  )
                                : const Text("Tentar novamente"),
                          ),
                        ],
                      ),
                    );
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
                        "Período: ${weather.isDay ? "Dia" : "Noite"}",
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
