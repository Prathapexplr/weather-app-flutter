import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/model/forecase_model.dart';
import '../model/weather_model.dart';
import '../service/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _service = WeatherService();
  Weather? weather;
  List<ForecastDay> forecast = [];

  bool isLoading = false;
  String? error;

  Future<void> fetchWeather(String city) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final weatherData = await _service.fetchWeather(city);
      final forecastData = await _service.fetchForecast(city);

      weather = weatherData;
      forecast = forecastData;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('last_city', city);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadLastCity() async {
    final prefs = await SharedPreferences.getInstance();
    final city = prefs.getString('last_city');
    if (city != null) {
      await fetchWeather(city);
    }
  }

  String getWeatherCondition(int code) {
    if (code >= 0 && code <= 3) {
      return "Clear";
    } else if (code >= 45 && code <= 48) {
      return "Fog";
    } else if (code >= 51 && code <= 57) {
      return "Drizzle";
    } else if (code >= 61 && code <= 67) {
      return "Rain";
    } else if (code >= 71 && code <= 77) {
      return "Snow";
    } else if (code >= 80 && code <= 82) {
      return "Showers";
    } else if (code >= 95 && code <= 99) {
      return "Thunderstorm";
    } else {
      return "Unknown";
    }
  }

  IconData getWeatherIcon(int code) {
    if (code >= 0 && code <= 3) {
      return Icons.wb_sunny;
    } else if (code >= 45 && code <= 48) {
      return Icons.cloud;
    } else if (code >= 51 && code <= 57) {
      return Icons.grain;
    } else if (code >= 61 && code <= 67) {
      return Icons.beach_access;
    } else if (code >= 71 && code <= 77) {
      return Icons.ac_unit;
    } else if (code >= 80 && code <= 82) {
      return Icons.shower;
    } else if (code >= 95 && code <= 99) {
      return Icons.flash_on;
    } else {
      return Icons.help_outline;
    }
  }
}
