import 'package:flutter/material.dart';

class DiseaseDetectorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Disease & Pest Detection')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt, size: 100, color: Colors.green),
              SizedBox(height: 20),
              Text('Use your camera to diagnose plants', style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.camera),
                label: Text('Open Camera'),
                onPressed: () {
                  // Integrate camera and AI model here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}