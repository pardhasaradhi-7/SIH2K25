import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather Forecast")),
      body: const Center(
          child: Text("Weather details will appear here 🌤️",
              style: TextStyle(fontSize: 18))),
    );
  }
}
