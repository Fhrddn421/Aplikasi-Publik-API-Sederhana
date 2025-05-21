import 'package:flutter/material.dart';
import 'package:konsumsi_api_app/models/weather_model.dart';

class WeatherCard extends StatefulWidget {
  final WeatherModel weather;

  const WeatherCard({super.key, required this.weather});

  @override
  WeatherCardState createState() => WeatherCardState();
}

class WeatherCardState extends State<WeatherCard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  String getEmoji(String desc) {
    desc = desc.toLowerCase();
    if (desc.contains('rain')) return '🌧️';
    if (desc.contains('cloud')) return '☁️';
    if (desc.contains('clear')) return '☀️';
    if (desc.contains('snow')) return '❄️';
    return '🌈';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Card(
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.blue[700],
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    widget.weather.cityName,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    '${getEmoji(widget.weather.description)} ${widget.weather.description.toUpperCase()}',
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    '${widget.weather.temperature.toStringAsFixed(1)}°C',
                    style: const TextStyle(fontSize: 48, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _infoItem(
                      Icons.opacity,
                      'Humidity',
                      '${widget.weather.humidity}%',
                    ),
                    _infoItem(
                      Icons.air,
                      'Wind',
                      '${widget.weather.windSpeed} m/s',
                    ),
                    _infoItem(
                      Icons.filter_drama,
                      'Cloudiness',
                      '${widget.weather.cloudiness}%',
                    ),
                    _infoItem(
                      Icons.grain,
                      'Precipitation',
                      '${widget.weather.precipitation?.toStringAsFixed(1) ?? '0'} mm',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // TabBar for switching between 24-Hour and 7-Day forecast
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: '24-Hour Forecast'),
                    Tab(text: '7-Day Forecast'),
                  ],
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white60,
                ),
                const SizedBox(height: 12),
                // TabBarView to display content based on selected tab
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // 24-Hour Forecast View
                      Column(
                        children:
                            widget.weather.hourly
                                .where((forecast) {
                                  final hour =
                                      int.tryParse(
                                        forecast.time.split(":")[0],
                                      ) ??
                                      0;
                                  return hour >= 6 && hour <= 24;
                                })
                                .map((forecast) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white54),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white.withAlpha(25),
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              getEmoji(forecast.description),
                                              style: const TextStyle(
                                                fontSize: 24,
                                              ),
                                            ),
                                            Text(
                                              forecast.time,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${forecast.temp.toStringAsFixed(0)}°C',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                forecast.description,
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                ),
                                              ),
                                              Text(
                                                'Humidity: ${forecast.humidity}%',
                                                style: const TextStyle(
                                                  color: Colors.white60,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                                .toList(),
                      ),
                      // 7-Day Forecast View (Add your own forecast data for 7 days)
                      Column(
                        children:
                            widget.weather.daily.map((forecast) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white54),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white.withAlpha(25),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          getEmoji(forecast.description),
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                        Text(
                                          forecast.date,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${forecast.temp.toStringAsFixed(0)}°C',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            forecast.description,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          Text(
                                            'Humidity: ${forecast.humidity}%',
                                            style: const TextStyle(
                                              color: Colors.white60,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white60)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
