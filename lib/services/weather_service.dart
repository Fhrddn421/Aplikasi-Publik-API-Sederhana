import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:konsumsi_api_app/models/weather_model.dart';
import 'package:intl/intl.dart'; // untuk format tanggal

class WeatherService {
  static const String _apiKey = 'ec466856cd7f8db9c9dc538ee2f951e1';
  static const String _baseUrlWeather =
      'https://api.openweathermap.org/data/2.5/weather';
  static const String _baseUrlForecast =
      'https://api.openweathermap.org/data/2.5/forecast';

  Future<WeatherModel> getWeatherByCity(String city) async {
    // Ambil cuaca sekarang
    final weatherResponse = await http.get(
      Uri.parse('$_baseUrlWeather?q=$city&units=metric&appid=$_apiKey'),
    );

    // Ambil data forecast 3 jam-an (5 hari)
    final forecastResponse = await http.get(
      Uri.parse('$_baseUrlForecast?q=$city&units=metric&appid=$_apiKey'),
    );

    if (weatherResponse.statusCode == 200 &&
        forecastResponse.statusCode == 200) {
      final weatherData = jsonDecode(weatherResponse.body);
      final forecastData = jsonDecode(forecastResponse.body);
      final List<dynamic> hourlyListJson = forecastData['list'];

      // --- Bikin daily forecast dari hourlyListJson ---
      Map<String, dynamic> firstDataPerDay = {};
      for (var item in hourlyListJson) {
        DateTime dt = DateTime.parse(item['dt_txt']);
        String dayKey = DateFormat('yyyy-MM-dd').format(dt);

        // Simpan satu data pertama untuk setiap hari
        if (!firstDataPerDay.containsKey(dayKey)) {
          firstDataPerDay[dayKey] = item;
        }

        // Ambil maksimal 7 hari
        if (firstDataPerDay.length == 7) break;
      }

      final List<dynamic> dailyListJson = firstDataPerDay.values.toList();

      return WeatherModel.fromJson(weatherData, hourlyListJson, dailyListJson);
    } else {
      throw Exception('GAGAL MENGAMBIL DATA CUACA !!!');
    }
  }
}
