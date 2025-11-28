class WeatherNow {
  double temp;
  String description;

  WeatherNow(this.temp, this.description);

  String writeWeather() {
    return 'Temperatura atual: ${temp}°C\nClima: ${description}';
  }

  // Novo: construtor a partir de JSON
  WeatherNow.fromJson(Map<String, dynamic> json)
    : temp = json['current_weather']['temperature'],
      description = json['current_weather']['weathercode'];
}
