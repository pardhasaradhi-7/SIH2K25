import 'package:flutter/material.dart';

class CropGuideScreen extends StatelessWidget {
  const CropGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crop Guide")),
      body: const Center(
          child: Text("Crop guide details will appear here 🌾",
              style: TextStyle(fontSize: 18))),
    );
  }
}
