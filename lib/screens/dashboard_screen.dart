import 'package:flutter/material.dart';
import 'weather_screen.dart';
import 'crop_guide_screen.dart';
import 'disease_detector_screen.dart';
import 'market_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: const Text('AgriAssist Dashboard'),
        backgroundColor: Colors.green.shade700,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: [
            _buildCard(context, 'Weather Forecast', Icons.cloud, Colors.blue.shade300, const WeatherScreen()),
            _buildCard(context, 'Crop Guide', Icons.grass, Colors.orange.shade300, const CropGuideScreen()),
            _buildCard(context, 'Disease Detector', Icons.camera_alt, Colors.red.shade300, const DiseaseDetectorScreen()),
            _buildCard(context, 'Market Prices', Icons.store, Colors.purple.shade300, const MarketScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, Color color, Widget screen) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color.withOpacity(0.7), color]),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 8, offset: const Offset(0,5))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            const SizedBox(height: 20),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
