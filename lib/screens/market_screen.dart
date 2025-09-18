import 'package:flutter/material.dart';

class MarketScreen extends StatelessWidget {
  final List<Map<String, String>> marketPrices = [
    {'crop': 'Wheat', 'price': '\$200/ton'},
    {'crop': 'Rice', 'price': '\$250/ton'},
    {'crop': 'Maize', 'price': '\$180/ton'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Market Prices')),
      body: ListView.builder(
        itemCount: marketPrices.length,
        itemBuilder: (context, index) {
          final item = marketPrices[index];
          return ListTile(
            leading: Icon(Icons.show_chart),
            title: Text(item['crop']!),
            trailing: Text(item['price']!),
            onTap: () {
              // Implement direct buyer connection
            },
          );
        },
      ),
    );
  }
}