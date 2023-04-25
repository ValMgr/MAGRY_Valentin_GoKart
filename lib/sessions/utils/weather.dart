import 'package:flutter/material.dart';

class WeatherUtils {
  static Icon getWeatherIcon(Map<String, dynamic> weather) {
    switch (weather['weather']) {
      case 'Clear':
        return const Icon(Icons.wb_sunny);
      case 'Clouds':
        return const Icon(Icons.cloud);
      case 'Rain':
        return const Icon(Icons.water_drop);
      case 'Snow':
        return const Icon(Icons.ac_unit);
      default:
        return const Icon(Icons.wb_sunny);
    }
  }
}
