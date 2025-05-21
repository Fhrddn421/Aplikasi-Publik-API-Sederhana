import 'package:flutter/material.dart';
import 'package:konsumsi_api_app/views/home_page.dart';
import 'package:provider/provider.dart';
import 'package:konsumsi_api_app/providers/weather_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => WeatherProvider())],
      child: MaterialApp(
        title: 'Aplikasi Publik API Sederhana',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
