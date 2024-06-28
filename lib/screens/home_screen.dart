import 'package:ecohub/screens/feature_screens/advisory_screen/advisory_screen.dart';
import 'package:ecohub/screens/feature_screens/blog_screen/blog_screen.dart';
import 'package:ecohub/screens/feature_screens/plant_disease_detection_screen/tflite_model.dart';
import 'package:ecohub/screens/feature_screens/weather_updates_screen/weather_page.dart';
import 'package:ecohub/screens/news_screen/news_screen.dart';
import 'package:ecohub/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        leading: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                )),
            child: Icon(Icons.person, size: 30, color: Colors.black),
          ),
        ),
        elevation: 0,
        title: const Text(
          'Eco Hub',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 5, right: 20),
          //   child: Image.asset('assets/logo.jpeg',
          //   width: 300,
          //   height: 300,),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 20,
                  children: [
                    Container(
                      height: 120,
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TfliteModel()));
                            },
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade900,
                                    spreadRadius: 0.5,
                                    blurRadius: 15,
                                    offset: Offset(
                                        5, 5), // changes position of shadow
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: 0.5,
                                    blurRadius: 15,
                                    offset: Offset(-6, -6),
                                  )
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/Designer-5.png',
                                  fit: BoxFit.cover,
                                  width: double
                                      .infinity, // Ensure the image takes the full width of the container
                                  height: double
                                      .infinity, // Ensure the image takes the full height of the container
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Detect Plant disease',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 120,
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdvisoryScreen()));
                            },
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade900,
                                    spreadRadius: 0.5,
                                    blurRadius: 15,
                                    offset: Offset(
                                        5, 5), // changes position of shadow
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: 0.5,
                                    blurRadius: 15,
                                    offset: Offset(-6, -6),
                                  )
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/Designer-8.png',
                                  fit: BoxFit.cover,
                                  width: double
                                      .infinity, // Ensure the image takes the full width of the container
                                  height: double
                                      .infinity, // Ensure the image takes the full height of the container
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Advisory',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 120,
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WeatherPage()));
                            },
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade900,
                                    spreadRadius: 0.5,
                                    blurRadius: 15,
                                    offset: Offset(
                                        5, 5), // changes position of shadow
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: 0.5,
                                    blurRadius: 15,
                                    offset: Offset(-6, -6),
                                  )
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/Designer-9.png',
                                  fit: BoxFit.cover,
                                  width: double
                                      .infinity, // Ensure the image takes the full width of the container
                                  height: double
                                      .infinity, // Ensure the image takes the full height of the container
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Weather',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 120,
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsScreen()));
                            },
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade900,
                                    spreadRadius: 0.5,
                                    blurRadius: 15,
                                    offset: Offset(
                                        5, 5), // changes position of shadow
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: 0.5,
                                    blurRadius: 15,
                                    offset: Offset(-6, -6),
                                  )
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/Designer-10.png',
                                  fit: BoxFit.cover,
                                  width: double
                                      .infinity, // Ensure the image takes the full width of the container
                                  height: double
                                      .infinity, // Ensure the image takes the full height of the container
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'News',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Blogs!',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BlogScreen()),
          );
        },
        child: Icon(Icons.article_outlined),
        backgroundColor: Colors.white,
      ),
    );
  }
}
