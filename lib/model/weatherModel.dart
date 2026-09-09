class WeatherModel {
  // current_weather
  final double temp;
  final String description;
  final String time;
  final DateTime localTime;
  final double windspeed;
  final int winddirection;
  final bool isDay;
  final int interval;
  // daily
  final double maxTemp;
  final double minTemp;
  final int rainProbability;
  final DateTime sunrise;
  final DateTime sunset;
  final double precipitationSum;

  WeatherModel(
    // current_weather
    this.temp,
    this.description,
    this.time,
    this.localTime,
    this.windspeed,
    this.winddirection,
    this.isDay,
    this.interval,
    // daily
    this.maxTemp,
    this.minTemp,
    this.rainProbability,
    this.sunrise,
    this.sunset,
    this.precipitationSum,
  );

  String writeWeather() {
    return '''
Temperatura: $temp°C
MAX: $maxTemp°C
MIN: $minTemp°C
Clima: $description
Probabilidade de Chuva: $rainProbability%
Quantidade de Chuva: $precipitationSum mm
Horário: $time
Sol nasce: $sunrise
Por do Sol: $sunset 
Vento: $windspeed km/h
Direção do vento: $winddirection°
Dia?: ${isDay ? "Sim" : "Não"}
''';
  }

  String get windDirectionCardinal {
    if (winddirection >= 337.5 || winddirection < 22.5) {
      return "N";
    } else if (winddirection < 67.5) {
      return "NE";
    } else if (winddirection < 112.5) {
      return "E";
    } else if (winddirection < 157.5) {
      return "SE";
    } else if (winddirection < 202.5) {
      return "S";
    } else if (winddirection < 247.5) {
      return "SW";
    } else if (winddirection < 292.5) {
      return "W";
    } else {
      return "NW";
    }
  }

  // Construtor a partir de JSON
  WeatherModel.fromJson(Map<String, dynamic> json)
    : temp = json['current_weather']['temperature'].toDouble(),
      time = json['current_weather']['time'],
      localTime = DateTime.parse(json["current_weather"]["time"]).toLocal(),
      windspeed = json['current_weather']['windspeed'].toDouble(),
      winddirection = json['current_weather']['winddirection'],
      isDay = json['current_weather']['is_day'] == 1,
      interval = json['current_weather']['interval'],
      description = WeatherModel.mapWeatherCode(
        json['current_weather']['weathercode'],
      ),
      //daily
      maxTemp = json['daily']['temperature_2m_max'][0].toDouble(),
      minTemp = json['daily']['temperature_2m_min'][0].toDouble(),
      rainProbability = json['daily']['precipitation_probability_max'][0],
      sunrise = DateTime.parse(json["daily"]["sunrise"][0]).toLocal(),
      sunset = DateTime.parse(json["daily"]["sunset"][0]).toLocal(),
      precipitationSum = json['daily']['precipitation_sum'][0].toDouble();

  // Conversor do código climático
  static String mapWeatherCode(int code) {
    if (code == 0) return "Céu limpo";
    if (code == 1) return "Predominantemente limpo";
    if (code == 2) return "Parcialmente nublado";
    if (code == 3) return "Nublado";

    if (code >= 45 && code <= 48) return "Névoa";
    if (code >= 51 && code <= 57) return "Garoa";
    if (code >= 61 && code <= 67) return "Chuva";
    if (code >= 80 && code <= 82) return "Pancadas de chuva";

    if (code == 95) return "Tempestade";

    return "Desconhecido";
  }
}
