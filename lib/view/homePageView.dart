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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${weather.temp}°C",
                                    style: const TextStyle(fontSize: 44),
                                  ),
                                  const SizedBox(height: 10, width: 10),

                                  Icon(
                                    weather.isDay
                                        ? Icons.wb_sunny_sharp
                                        : Icons.dark_mode_sharp,
                                    size: 40,
                                  ),

                                  const SizedBox(height: 10, width: 10),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        " MAX: ${weather.maxTemp}°C",
                                        style: const TextStyle(fontSize: 22),
                                      ),
                                      Text(
                                        " MIN: ${weather.minTemp}°C",
                                        style: const TextStyle(fontSize: 22),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(thickness: 1, height: 20),
                              Text(
                                "${weather.description}",
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Text(
                                "Chance de chuva: ${weather.rainProbability}%",
                                style: const TextStyle(fontSize: 18),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: LinearProgressIndicator(
                                  value: weather.rainProbability / 100,
                                ),
                              ),

                              const SizedBox(width: 10),

                              Text(
                                "${weather.precipitationSum} mm",
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                "Velocidade do vento: ${weather.windspeed} km/h",
                                style: const TextStyle(fontSize: 16),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                "Direção do vento: ${weather.winddirection}° [${weather.windDirectionCardinal}]",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /*
                      Text(
                        "Horário da medição (local): ${weather.localTime}\nHorário da medição (servidor): ${weather.time}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        "Intervalo da medição: ${weather.interval} segundos",
                        style: const TextStyle(fontSize: 16),
                      ),
                      */
                    ],
                  );
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    futureWeather = WeatherService().fetchWeather(
                      latitude: -22.85,
                      longitude: -47.61,
                      //Riodas
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
