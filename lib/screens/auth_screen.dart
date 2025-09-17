import 'package:flutter/material.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController _loginEmail = TextEditingController();
  final TextEditingController _loginPassword = TextEditingController();
  final TextEditingController _registerName = TextEditingController();
  final TextEditingController _registerEmail = TextEditingController();
  final TextEditingController _registerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmail.dispose();
    _loginPassword.dispose();
    _registerName.dispose();
    _registerEmail.dispose();
    _registerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.green.shade600, Colors.green.shade200], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Icon(Icons.agriculture, size: 80, color: Colors.white),
              const SizedBox(height: 10),
              const Text("AgriAssist", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              const Text("Smart Farming Companion", style: TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 40),

              // Tabs
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                tabs: const [Tab(text: "Login"), Tab(text: "Register")],
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))],
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Login Tab
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: _loginEmail,
                              decoration: const InputDecoration(labelText: "Email", prefixIcon: Icon(Icons.email)),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: _loginPassword,
                              obscureText: true,
                              decoration: const InputDecoration(labelText: "Password", prefixIcon: Icon(Icons.lock)),
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              child: const Text("Login"),
                            ),
                          ],
                        ),
                      ),

                      // Register Tab
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: _registerName,
                              decoration: const InputDecoration(labelText: "Name", prefixIcon: Icon(Icons.person)),
                            ),
                            const SizedBox(height: 15),
                            TextField(
                              controller: _registerEmail,
                              decoration: const InputDecoration(labelText: "Email", prefixIcon: Icon(Icons.email)),
                            ),
                            const SizedBox(height: 15),
                            TextField(
                              controller: _registerPassword,
                              obscureText: true,
                              decoration: const InputDecoration(labelText: "Password", prefixIcon: Icon(Icons.lock)),
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              child: const Text("Register"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
