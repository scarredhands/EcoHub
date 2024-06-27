import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherForecastPage extends StatefulWidget {
  final String cityName;

  WeatherForecastPage({required this.cityName});

  @override
  _WeatherForecastPageState createState() => _WeatherForecastPageState();
}

class _WeatherForecastPageState extends State<WeatherForecastPage> {
  final String apiKey =
      'd481771a6c6496e130d6da77bdf84e7f'; // Replace with your actual API key
  List _forecastData = [];
  bool _loading = true;
  late String _cityName;
  String _error = "";

  @override
  void initState() {
    super.initState();
    _cityName = widget.cityName;
    _fetchWeatherForecast();
  }

  Future<void> _fetchWeatherForecast() async {
    setState(() {
      _loading = true;
      _error = "";
    });

    try {
      final response = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$_cityName&appid=$apiKey&units=metric'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List forecastList = data['list'];

        final Map<String, dynamic> filteredForecast = {};
        for (var forecast in forecastList) {
          final date = DateTime.parse(forecast['dt_txt']);
          final day = DateFormat('yyyy-MM-dd').format(date);
          if (!filteredForecast.containsKey(day) || date.hour == 12) {
            filteredForecast[day] = forecast;
          }
        }

        setState(() {
          _cityName = data['city']['name'];
          _forecastData = filteredForecast.values.toList();
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to load weather data: ${response.reasonPhrase}';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        title: const Text(
          '5-Day Weather Forecast',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
              ? Center(child: Text(_error))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('Location: $_cityName',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'RedditMono')),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _forecastData.length,
                          itemBuilder: (context, index) {
                            final forecast = _forecastData[index];
                            final date = DateTime.parse(forecast['dt_txt']);
                            final day = DateFormat('EEEE, MMM d').format(date);
                            final temp =
                                forecast['main']['temp'].toStringAsFixed(1);
                            final tempMin =
                                forecast['main']['temp_min'].toStringAsFixed(1);
                            final tempMax =
                                forecast['main']['temp_max'].toStringAsFixed(1);
                            final feelsLike = forecast['main']['feels_like']
                                .toStringAsFixed(1);
                            final humidity =
                                forecast['main']['humidity'].toString();
                            final windSpeed =
                                forecast['wind']['speed'].toStringAsFixed(1);
                            final weatherDescription =
                                forecast['weather'][0]['description'];

                            return Card(
                              color: Colors.grey[900],
                              child: ListTile(
                                title: Text(
                                  day,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Temperature: $temp°C',
                                      style: const TextStyle(
                                          color: Colors.purpleAccent,
                                          fontFamily: 'RedditMono'),
                                    ),
                                    Text(
                                      'Description: $weatherDescription',
                                      style: const TextStyle(
                                          color: Colors.purpleAccent,
                                          fontFamily: 'RedditMono'),
                                    ),
                                    Text(
                                      'Feels Like: $feelsLike°C',
                                      style: const TextStyle(
                                          color: Colors.purpleAccent,
                                          fontFamily: 'RedditMono'),
                                    ),
                                    Text(
                                      'Min Temp: $tempMin°C',
                                      style: const TextStyle(
                                          color: Colors.purpleAccent,
                                          fontFamily: 'RedditMono'),
                                    ),
                                    Text(
                                      'Max Temp: $tempMax°C',
                                      style: const TextStyle(
                                          color: Colors.purpleAccent,
                                          fontFamily: 'RedditMono'),
                                    ),
                                    Text(
                                      'Humidity: $humidity%',
                                      style: const TextStyle(
                                          color: Colors.purpleAccent,
                                          fontFamily: 'RedditMono'),
                                    ),
                                    Text(
                                      'Wind Speed: $windSpeed m/s',
                                      style: const TextStyle(
                                          color: Colors.purpleAccent,
                                          fontFamily: 'RedditMono'),
                                    ),
                                  ],
                                ),
                                trailing: SizedBox(
                                    height: 100,
                                    child: Image.asset(
                                      getImage(
                                        forecast['weather'][0]['main'],
                                      ),
                                    )),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  String getImage(String? cond) {
    if (cond == null) {
      return 'assets/sun.png';
    }

    switch (cond.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.png';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/raining.png';
      case 'thunderstorm':
        return 'assets/thunder.png';
      case 'clear':
        return 'assets/sun.png';

      default:
        return 'assets/sun.png';
    }
  }
}
