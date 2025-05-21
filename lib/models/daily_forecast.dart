import 'package:intl/intl.dart';

class DailyForecast {
  final String description;
  final String date;
  final double temp;
  final int humidity;

  DailyForecast({
    required this.description,
    required this.date,
    required this.temp,
    required this.humidity,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      description: json['weather'][0]['description'],
      date: DateFormat('EEEE, dd MMM').format(DateTime.parse(json['dt_txt'])),
      temp: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'],
    );
  }
}
