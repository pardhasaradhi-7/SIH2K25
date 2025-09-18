import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Forecast')),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.cloud, size: 80, color: Colors.blue),
                SizedBox(height: 10),
                Text('Sunny, 28°C', style: TextStyle(fontSize: 24)),
                SizedBox(height: 10),
                Text('Humidity: 60%', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Refresh weather data
                  },
                  child: Text('Refresh'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}