import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_flutter_app/services/ai_service.dart';
import 'package:path/path.dart' as p;

class DiseaseDetectorScreen extends StatefulWidget {
  const DiseaseDetectorScreen({super.key});

  @override
  State<DiseaseDetectorScreen> createState() => _DiseaseDetectorScreenState();
}

class _DiseaseDetectorScreenState extends State<DiseaseDetectorScreen> {
  bool _loading = false;
  String? _result;

  @override
  Widget build(BuildContext context) {
    final aiService = Provider.of<AIService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("🧪 Disease Detector")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_loading) const CircularProgressIndicator(),
            if (_result != null && !_loading)
              Card(
                color: Colors.green.shade50,
                margin: const EdgeInsets.all(12),
                child: ListTile(
                  leading: const Icon(Icons.eco, color: Colors.green),
                  title: Text("Result: $_result"),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text("Detect Disease"),
              onPressed: () async {
                setState(() {
                  _loading = true;
                  _result = null;
                });

                final filePath = p.join(
                  'storage',
                  'emulated',
                  '0',
                  'Pictures',
                  'sample.jpg',
                );

                final result = await aiService.detectDisease(filePath);

                setState(() {
                  _loading = false;
                  _result = result;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
