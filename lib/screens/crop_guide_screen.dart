import 'package:flutter/material.dart';

class CropGuideScreen extends StatelessWidget {
  final List<String> crops = ['Wheat', 'Rice', 'Maize', 'Cotton'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crop Guide')),
      body: ListView.builder(
        itemCount: crops.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8),
            elevation: 2,
            child: ListTile(
              leading: Icon(Icons.grass),
              title: Text(crops[index]),
              subtitle: Text('Step-by-step guide for ${crops[index]}...'),
              onTap: () {
                // Show detailed info
              },
            ),
          );
        },
      ),
    );
  }
}