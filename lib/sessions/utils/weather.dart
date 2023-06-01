import 'package:flutter/material.dart';

enum Weather { sunny, cloudy, rainy, windy, snowy }

class WeatherUtils {
  static Icon getWeatherIcon(Map<String, dynamic> weather) {
    switch (weather['weather']) {
      case Weather.sunny:
        return const Icon(Icons.wb_sunny);
      case Weather.cloudy:
        return const Icon(Icons.cloud);
      case Weather.rainy:
        return const Icon(Icons.water_drop);
      case Weather.windy:
        return const Icon(Icons.wind_power);
      case Weather.snowy:
        return const Icon(Icons.ac_unit);
      default:
        return const Icon(Icons.wb_sunny);
    }
  }
}
