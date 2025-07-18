import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/forecase_model.dart';
import '../model/weather_model.dart';

class WeatherService {
  Future<Weather> fetchWeather(String city) async {
    final geoRes = await http.get(
      Uri.parse('https://geocoding-api.open-meteo.com/v1/search?name=$city'),
    );

    if (geoRes.statusCode != 200) throw Exception('City not found');
    final geoData = jsonDecode(geoRes.body);
    if (geoData['results'] == null || geoData['results'].isEmpty) {
      throw Exception('City not found');
    }

    final location = geoData['results'][0];
    final lat = location['latitude'];
    final lon = location['longitude'];
    final cityName = location['name'];

    final weatherRes = await http.get(
      Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,weathercode&daily=temperature_2m_max,temperature_2m_min,weathercode&timezone=auto',
      ),
    );

    if (weatherRes.statusCode != 200)
      throw Exception('Failed to fetch weather');

    final data = jsonDecode(weatherRes.body);
    return Weather.fromJson(data, cityName);
  }

  Future<List<ForecastDay>> fetchForecast(String city) async {
    final geoRes = await http.get(
      Uri.parse('https://geocoding-api.open-meteo.com/v1/search?name=$city'),
    );

    if (geoRes.statusCode != 200) throw Exception('City not found');
    final geoData = jsonDecode(geoRes.body);
    final location = geoData['results'][0];
    final lat = location['latitude'];
    final lon = location['longitude'];

    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&daily=temperature_2m_max,temperature_2m_min,weathercode&timezone=auto',
    );

    final res = await http.get(url);
    if (res.statusCode != 200) throw Exception('Failed to fetch forecast');

    final data = jsonDecode(res.body);
    final List<ForecastDay> forecast = [];

    for (int i = 0; i < 3; i++) {
      forecast.add(
        ForecastDay(
          date: DateTime.parse(data['daily']['time'][i]),
          tempMax: data['daily']['temperature_2m_max'][i].toDouble(),
          tempMin: data['daily']['temperature_2m_min'][i].toDouble(),
          weatherCode: data['daily']['weathercode'][i],
        ),
      );
    }

    return forecast;
  }
}
