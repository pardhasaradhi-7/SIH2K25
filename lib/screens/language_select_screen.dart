import 'package:flutter/material.dart';

class LanguageSelectScreen extends StatelessWidget {
  final List<String> languages = ['English', 'Hindi', 'Regional Language'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Language')),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.language),
            title: Text(languages[index]),
            onTap: () {
              // Save language preference
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}