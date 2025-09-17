import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class LanguageSelectScreen extends StatelessWidget {
  const LanguageSelectScreen({super.key});

  Future<void> _saveLanguage(BuildContext context, String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(language: language),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Language")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _saveLanguage(context, "English"),
              child: const Text("English"),
            ),
            ElevatedButton(
              onPressed: () => _saveLanguage(context, "हिंदी"),
              child: const Text("हिंदी"),
            ),
            ElevatedButton(
              onPressed: () => _saveLanguage(context, "తెలుగు"),
              child: const Text("తెలుగు"),
            ),
          ],
        ),
      ),
    );
  }
}
