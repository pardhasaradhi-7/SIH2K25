import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String language;
  const HomeScreen({super.key, required this.language});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<String> _titles = [
    "Dashboard",
    "Weather",
    "Market",
    "Profile",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_titles[_selectedIndex]} - ${widget.language}"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: _buildDashboard(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: "Weather"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Market"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildCard(Icons.cloud, "Weather Updates", Colors.blue),
        _buildCard(Icons.grass, "Crop Guidance", Colors.green),
        _buildCard(Icons.medical_services, "Fertilizer Advice", Colors.orange),
        _buildCard(Icons.camera_alt, "Disease Detection", Colors.red),
        _buildCard(Icons.currency_rupee, "Market Prices", Colors.purple),
        _buildCard(Icons.book, "Knowledge Center", Colors.teal),
      ],
    );
  }

  Widget _buildCard(IconData icon, String title, Color color) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$title feature coming soon!")),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
