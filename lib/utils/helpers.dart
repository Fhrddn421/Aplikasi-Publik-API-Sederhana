class Helpers {
  /// Mengubah huruf pertama setiap kata menjadi huruf kapital
  static String capitalizeWords(String text) {
    return text
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }

  /// Mengubah suhu Celsius ke Fahrenheit (jika diperlukan)
  static double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  /// Format suhu dengan 1 angka desimal dan simbol derajat
  static String formatTemperature(double temp) {
    return '${temp.toStringAsFixed(1)}°C';
  }
}
