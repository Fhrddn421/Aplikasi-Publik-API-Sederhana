import 'hourly_forecast.dart';
import 'daily_forecast.dart';

class WeatherModel {
  final String cityName;
  final String description;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final int cloudiness;
  final dynamic precipitation;
  final List<HourlyForecast> hourly;
  final List<DailyForecast> daily; // Properti untuk ramalan 7 hari

  WeatherModel({
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.cloudiness,
    required this.precipitation,
    required this.hourly,
    required this.daily, // Menambahkan parameter daily
  });

  factory WeatherModel.fromJson(
    Map<String, dynamic> json,
    List<dynamic> hourlyListJson,
    List<dynamic> dailyListJson, // Parameter baru untuk ramalan harian
  ) {
    List<HourlyForecast> parsedHourly =
        hourlyListJson.take(8).map((e) => HourlyForecast.fromJson(e)).toList();
    List<DailyForecast> parsedDaily =
        dailyListJson.map((e) => DailyForecast.fromJson(e)).toList();

    return WeatherModel(
      cityName: json['name'],
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      cloudiness: json['clouds']['all'],
      precipitation: _getPrecipitation(json),
      hourly: parsedHourly,
      daily: parsedDaily, // Menyimpan data ramalan harian
    );
  }

  static dynamic _getPrecipitation(Map<String, dynamic> json) {
    if (json['rain'] != null) {
      return json['rain']['1h'] ?? json['rain']['3h'];
    }
    return null;
  }
}
