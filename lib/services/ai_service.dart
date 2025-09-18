class AIService {
  // Example function to detect plant disease
  Future<String> diagnosePlantDisease(String imagePath) async {
    // Call your AI model API
    await Future.delayed(Duration(seconds: 2));
    return 'Healthy'; // or 'Disease detected'
  }
}