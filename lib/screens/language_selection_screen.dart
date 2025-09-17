import 'package:flutter/material.dart';
import 'login_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? _selectedLanguage;

  // Example: Many languages (you can add even more 🌍)
  final List<String> _languages = [
    "English",
    "తెలుగు (Telugu)",
    "हिंदी (Hindi)",
    "தமிழ் (Tamil)",
    "বাংলা (Bangla)",
    "اردو (Urdu)",
    "Español (Spanish)",
    "Français (French)",
    "Deutsch (German)",
    "Italiano (Italian)",
    "Português (Portuguese)",
    "中文 (Chinese)",
    "日本語 (Japanese)",
    "한국어 (Korean)",
    "Русский (Russian)",
    "العربية (Arabic)",
    "Türkçe (Turkish)",
  ];

  void _proceed() {
    if (_selectedLanguage != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LoginScreen(language: _selectedLanguage!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a language")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.language, size: 80, color: Colors.green),
              const SizedBox(height: 20),
              const Text(
                "Select Your Language 🌍",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Language",
                ),
                value: _selectedLanguage,
                items: _languages
                    .map((lang) => DropdownMenuItem(
                          value: lang,
                          child: Text(lang),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                },
              ),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _proceed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
