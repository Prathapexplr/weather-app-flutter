import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/weather_provider.dart';
import 'view/weather_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WeatherProvider()..loadLastCity(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E1E2C),
      ),
      home: const WeatherScreen(),
    );
  }
}
