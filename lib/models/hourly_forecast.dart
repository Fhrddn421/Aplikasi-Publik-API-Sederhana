class HourlyForecast {
  final String time; // Misalnya: "12:00"
  final String description; // Misalnya: "few clouds"
  final double temp; // Misalnya: 30.5
  final int humidity;

  HourlyForecast({
    required this.time,
    required this.description,
    required this.temp,
    required this.humidity,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: json['dt_txt'].substring(11, 16), // Ambil jam-menit "12:00"
      description: json['weather'][0]['description'],
      temp: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'], // Tambahkan ini
    );
  }
}
