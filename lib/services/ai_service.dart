import 'dart:math';

class AIService {
  Future<String> detectDisease(String imagePath) async {
    await Future.delayed(const Duration(seconds: 2));
    List<String> diseases = ['Leaf Blight', 'Powdery Mildew', 'Rust Fungus', 'Healthy Plant'];
    return diseases[Random().nextInt(diseases.length)];
  }
}
