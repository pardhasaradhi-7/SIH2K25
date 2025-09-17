import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import your screens and services
import 'screens/splash_screen.dart';
import 'screens/language_selection_screen.dart';
import 'services/ai_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AIService>(create: (_) => AIService()),
      ],
      child: const AgriAssistApp(),
    ),
  );
}

class AgriAssistApp extends StatelessWidget {
  const AgriAssistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgriAssist 🌱',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(), // No const if dynamic
        '/language': (context) => const LanguageSelectionScreen(),
        // Add more routes like '/dashboard' later
      },
    );
  }
}
