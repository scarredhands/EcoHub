import 'package:flutter/material.dart';

import 'detail_weather_page.dart';

class SearchCurrentWeather extends StatelessWidget {
  final Map<String, dynamic> cityWeather;

  const SearchCurrentWeather({Key? key, required this.cityWeather})
      : super(key: key);

  String getImage(String cond) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        title: Text('Current Weather'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Current Weather in ${cityWeather['name']}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'RedditMono'),
              ),
              SizedBox(height: 10),
              Image.asset(
                getImage(cityWeather['weather'][0]['main']),
                height: 260,
                width: 260,
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple[700],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Temperature-${cityWeather['main']['temp']}°C',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'RedditMono'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Condition-${cityWeather['weather'][0]['description']}',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'RedditMono'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Feels Like-${cityWeather['main']['feels_like']}°C',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'RedditMono'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WeatherForecastPage(cityName: cityWeather['name']),
                    ),
                  );
                },
                child: Text(
                  'Tap into the Future',
                  style: TextStyle(
                      color: Colors.purpleAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'RedditMono'),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.search_rounded,
          size: 40,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
