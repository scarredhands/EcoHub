import 'dart:convert';

import 'package:ecohub/screens/feature_screens/weather_updates_screen/search_current_weather.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final String apiKey =
      'd481771a6c6496e130d6da77bdf84e7f'; // Replace with your actual API key
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _cities = [];
  Map<String, dynamic>? _currentWeather;

  void _searchCities(String query) async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/find?q=$query&type=like&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      setState(() {
        final data = json.decode(response.body);
        _cities = List<Map<String, dynamic>>.from(data['list'].map((city) => {
              'name': city['name'],
              'country': city['sys']['country'],
            }));
      });
    } else {
      setState(() {
        _cities = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load cities: ${response.reasonPhrase}'),
      ));
    }
  }

  void _getCurrentWeather(String cityName) async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _currentWeather = json.decode(response.body);
        _searchController.clear(); // Clear the search field
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              SearchCurrentWeather(cityWeather: _currentWeather!),
        ),
      );
    } else {
      setState(() {
        _currentWeather = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load weather data: ${response.reasonPhrase}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          'Search City',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'RedditMono',
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.purple[700],
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(
                  color: Colors.white, // Change the text color
                  fontFamily: 'RedditMono', // Change the font family
                ),
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.white),
                  labelText: 'Enter city name',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      _searchCities(_searchController.text);
                    },
                  ),
                ),
                onSubmitted: (value) {
                  _searchCities(value);
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _cities.length,
              itemBuilder: (context, index) {
                final city = _cities[index];
                return ListTile(
                  title: Text(
                    city['name'],
                    style: const TextStyle(
                        color: Colors.black, fontFamily: 'RedditMono'),
                  ),
                  subtitle: Text(
                    city['country'],
                    style: const TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    _getCurrentWeather(city['name']);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
