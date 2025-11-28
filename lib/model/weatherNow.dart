class WeatherNow {
  final double temp;
  final String description;
  final String time;
  final DateTime localTime;
  final double windspeed;
  final int winddirection;
  final bool isDay;
  final int interval;

  WeatherNow(
    this.temp,
    this.description,
    this.time,
    this.localTime,
    this.windspeed,
    this.winddirection,
    this.isDay,
    this.interval,
  );

  String writeWeather() {
    return '''
Temperatura: ${temp}°C
Clima: $description
Horário: $time
Vento: ${windspeed} km/h
Direção do vento: ${winddirection}°
Dia?: ${isDay ? "Sim" : "Não"}
''';
  }

  // Construtor a partir de JSON
  WeatherNow.fromJson(Map<String, dynamic> json)
    : temp = json['current_weather']['temperature'].toDouble(),
      time = json['current_weather']['time'],
      localTime = DateTime.parse(json["current_weather"]["time"]).toLocal(),
      windspeed = json['current_weather']['windspeed'].toDouble(),
      winddirection = json['current_weather']['winddirection'],
      isDay = json['current_weather']['is_day'] == 1,
      interval = json['current_weather']['interval'],
      description = WeatherNow.mapWeatherCode(
        json['current_weather']['weathercode'],
      );

  // Conversor do código climático
  static String mapWeatherCode(int code) {
    if (code == 0) return "Clear sky";
    if (code == 1) return "Mostly clear";
    if (code == 2) return "Partly cloudy";
    if (code == 3) return "Overcast";

    if (code >= 45 && code <= 48) return "Fog";
    if (code >= 51 && code <= 57) return "Drizzle";
    if (code >= 61 && code <= 67) return "Rain";
    if (code >= 80 && code <= 82) return "Rain showers";

    if (code == 95) return "Thunderstorm";

    return "Unknown";
  }
}
