import 'package:flutter/material.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Market Prices")),
      body: const Center(
          child: Text("Market prices will appear here 🏪",
              style: TextStyle(fontSize: 18))),
    );
  }
}
