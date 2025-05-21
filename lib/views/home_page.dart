import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:konsumsi_api_app/providers/weather_provider.dart';
import 'components/weather_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cityController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard API Cuaca"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔍 Input kota
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Masukkan Nama Kota:',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_cityController.text.isNotEmpty) {
                      weatherProvider.fetchWeather(_cityController.text);
                    }
                  },
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  weatherProvider.fetchWeather(value);
                }
              },
            ),
            const SizedBox(height: 24),

            // 📡 State feedback
            if (weatherProvider.isLoading)
              const CircularProgressIndicator()
            else if (weatherProvider.errorMessage != null)
              Text(
                weatherProvider.errorMessage!,
                style: const TextStyle(color: Colors.red),
              )
            else if (weatherProvider.weather != null)
              WeatherCard(weather: weatherProvider.weather!)
            else
              const Text("Masukkan kota untuk melihat cuaca."),
          ],
        ),
      ),
    );
  }
}
