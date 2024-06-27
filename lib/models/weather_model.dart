class Weather {
  final String cityName;
  final double temp;
  final String cond;
  final double min_temp;
  final double max_temp;
  final double feels_like;
  final int humidity;
  final double wind_speed;
  final String disc;

  Weather(
      {required this.disc,
      required this.min_temp,
      required this.max_temp,
      required this.feels_like,
      required this.cityName,
      required this.temp,
      required this.cond,
      required this.humidity,
      required this.wind_speed});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temp: json['main']['temp'].toDouble(),
        cond: json['weather'][0]['main'],
        min_temp: json['main']['temp_min'],
        max_temp: json['main']['temp_max'],
        feels_like: json['main']['feels_like'],
        humidity: json['main']['humidity'],
        wind_speed: json['wind']['speed'],
        disc: json['weather'][0]['description']);
  }
}
