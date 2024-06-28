import 'package:ecohub/screens/feature_screens/weather_updates_screen/search.dart';
import 'package:flutter/material.dart';

import '../../../models/weather_model.dart';
import '../../../services/weather_service.dart';
import 'detail_weather_page.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('d481771a6c6496e130d6da77bdf84e7f');

  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
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

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Center(
          child: Text(
            'Weather Update',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'RedditMono'),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 250, child: Image.asset(getImage(_weather?.cond))),
            Text(
              "It's ${_weather?.temp.round().toString()}°C in ${_weather?.cityName} ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RedditMono'),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                  //color: Colors.purple[700],
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    "Weather Condition-${_weather?.disc}" ?? "",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RedditMono'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Feels Like-${_weather?.feels_like.toStringAsFixed(1)}" ??
                        "",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RedditMono'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Mininum Temp-${_weather?.min_temp.toString()}°C" ?? "",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RedditMono'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Maximum Temp-${_weather?.max_temp.toString()}°C" ?? "",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RedditMono'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Humidity-${_weather?.humidity.toString()}" ?? "",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RedditMono'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Wind Speed-${_weather?.wind_speed.toString()} m/s" ?? "",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RedditMono'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherForecastPage(
                      cityName: _weather!.cityName,
                    ),
                  ),
                );
              },
              child: Text(
                'Tap into the Future',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RedditMono'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.search_rounded,
          size: 40,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(),
            ),
          );
        },
      ),
    );
  }
}
