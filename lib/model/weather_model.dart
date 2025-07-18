class Weather {
  final String city;
  final double temperature;
  final int condition;

  Weather({
    required this.city,
    required this.temperature,
    required this.condition,
  });

  factory Weather.fromJson(Map<String, dynamic> json, String cityName) {
    return Weather(
      city: cityName,
      temperature: json['current']['temperature_2m'],
      condition: json['current']['weathercode'],
    );
  }
}
