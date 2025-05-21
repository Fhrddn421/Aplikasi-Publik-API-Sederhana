import 'package:flutter/material.dart';
import 'package:konsumsi_api_app/models/weather_model.dart';
import 'package:konsumsi_api_app/services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  WeatherModel? _weather;
  WeatherModel? get weather => _weather;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _weatherService.getWeatherByCity(city);
      _weather = result;
    } catch (e) {
      _errorMessage = " ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
