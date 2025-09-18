import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/language'),
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to your dashboard!', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}