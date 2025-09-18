import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:math';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String? savedLocale = prefs.getString('locale');
  runApp(SmartFarmingProApp(initialLocale: savedLocale));
}

class SmartFarmingProApp extends StatefulWidget {
  final String? initialLocale;

  SmartFarmingProApp({this.initialLocale});

  @override
  _SmartFarmingProAppState createState() => _SmartFarmingProAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    final state = context.findAncestorStateOfType<_SmartFarmingProAppState>();
    state?.setLocale(newLocale);
  }
}

class _SmartFarmingProAppState extends State<SmartFarmingProApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale != null ? Locale(widget.initialLocale!) : Locale('en');
  }

  void setLocale(Locale newLocale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', newLocale.languageCode);
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Farming Pro',
      debugShowCheckedModeBanner: false,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.system,
      locale: _locale,
      localizationsDelegates: [
        // Remove localization for now
        // AppLocalizations.delegate,
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('hi'),
        Locale('te'),
        Locale('ta'),
        Locale('kn'),
      ],
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/language': (context) => LanguageSelectScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/crop-guide': (context) => CropGuideScreen(),
        '/disease-detector': (context) => DiseaseDetectorScreen(),
        '/weather': (context) => WeatherScreen(),
        '/market': (context) => MarketScreen(),
        '/profile': (context) => ProfileScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }

  static ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF4CAF50),
        brightness: Brightness.light,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
      ),
    );
  }

  static ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF4CAF50),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: const Color(0xFF1E1E1E),
      ),
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startSplashSequence();
  }

  void _initAnimations() {
    _fadeController = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);
    _scaleController = AnimationController(duration: Duration(milliseconds: 1200), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut));
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut));
  }

  void _startSplashSequence() async {
    await Future.delayed(Duration(milliseconds: 300));
    _scaleController.forward();
    await Future.delayed(Duration(milliseconds: 200));
    _fadeController.forward();
    await Future.delayed(Duration(milliseconds: 3000));
    Navigator.pushReplacementNamed(context, '/language');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4CAF50), Color(0xFF8BC34A), Color(0xFF66BB6A)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                      child: Icon(Icons.agriculture, size: 80, color: Colors.white),
                    ),
                  );
                },
              ),
              SizedBox(height: 32),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    Text('Smart Farming Pro', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2)),
                    SizedBox(height: 8),
                    Text('AI-Powered Agricultural Intelligence', style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w300)),
                    SizedBox(height: 40),
                    SizedBox(width: 40, height: 40, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }
}

// Language Select Screen
class LanguageSelectScreen extends StatefulWidget {
  @override
  _LanguageSelectScreenState createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  int selectedIndex = 0;
  final List<LanguageOption> languages = [
    LanguageOption('English', '🇺🇸', 'en'),
    LanguageOption('हिंदी', '🇮🇳', 'hi'),
    LanguageOption('తెలుగు', '🇮🇳', 'te'),
    LanguageOption('தமிழ்', '🇮🇳', 'ta'),
    LanguageOption('ಕನ್ನಡ', '🇮🇳', 'kn'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Language')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose your preferred language', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('You can change this later in settings', style: TextStyle(fontSize: 16)),
            SizedBox(height: 32),
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (_, index) {
                  final lang = languages[index];
                  final selected = selectedIndex == index;
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.only(bottom: 12),
                    child: Card(
                      elevation: selected ? 8 : 0,
                      color: selected ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : null,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: Text(lang.flag, style: TextStyle(fontSize: 32)),
                        title: Text(
                          lang.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: selected ? Theme.of(context).colorScheme.primary : null,
                          ),
                        ),
                        trailing: selected ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary) : Icon(Icons.radio_button_unchecked),
                        onTap: () {
                          setState(() => selectedIndex = index);
                          HapticFeedback.lightImpact();
                          SmartFarmingProApp.setLocale(context, Locale(lang.code));
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Login Screen
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) => value != null && value.contains('@') ? null : 'Enter a valid email',
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                obscureText: _obscurePassword,
                validator: (value) => value != null && value.length >= 6 ? null : 'Password too short',
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => _isLoading = true);
                          await Future.delayed(Duration(seconds: 2));
                          Navigator.pushReplacementNamed(context, '/dashboard');
                        }
                      },
                child: _isLoading
                    ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : Text('Login'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Register Screen
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Account')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) => value != null && value.isNotEmpty ? null : 'Enter your name',
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) => value != null && value.contains('@') ? null : 'Enter a valid email',
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) => value != null && value.length >= 10 ? null : 'Enter a valid phone number',
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                obscureText: _obscurePassword,
                validator: (value) => value != null && value.length >= 6 ? null : 'Password too short',
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => _isLoading = true);
                          await Future.delayed(Duration(seconds: 2));
                          Navigator.pushReplacementNamed(context, '/dashboard');
                        }
                      },
                child: _isLoading
                    ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : Text('Create Account'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                child: Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dashboard Screen
class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with TickerProviderStateMixin {
  Timer? _weatherTimer;
  WeatherData _weatherData = WeatherData();

  @override
  void initState() {
    super.initState();
    _startWeatherUpdates();
  }

  void _startWeatherUpdates() {
    _weatherTimer = Timer.periodic(Duration(seconds: 30), (_) {
      setState(() => _weatherData.updateRandomData());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Good Morning, Farmer!'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withOpacity(0.8)],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(icon: Icon(Icons.notifications_outlined), onPressed: () {}),
              IconButton(icon: Icon(Icons.person_outline), onPressed: () => Navigator.pushNamed(context, '/profile')),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildWeatherCard(),
                SizedBox(height: 16),
                _buildQuickActions(),
                SizedBox(height: 16),
                _buildCropStatus(),
                SizedBox(height: 16),
                _buildMarketPrices(),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.grass), label: 'Crops'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Analytics'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: 0,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/crop-guide');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/settings');
          }
        },
      ),
    );
  }

  Widget _buildWeatherCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Weather Now', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Icon(Icons.refresh, color: Theme.of(context).colorScheme.primary),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(_weatherData.getWeatherIcon(), size: 48, color: Colors.orange),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${_weatherData.temperature}°C', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    Text(_weatherData.condition, style: TextStyle(fontSize: 16)),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    _buildWeatherStat('Humidity', '${_weatherData.humidity}%'),
                    SizedBox(height: 8),
                    _buildWeatherStat('Wind', '${_weatherData.windSpeed} km/h'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 12)),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      QuickAction('Scan Plant', Icons.camera_alt, Color(0xFF4CAF50), '/disease-detector'),
      QuickAction('Weather', Icons.wb_sunny, Color(0xFF2196F3), '/weather'),
      QuickAction('Market', Icons.trending_up, Color(0xFFFF9800), '/market'),
      QuickAction('Crop Guide', Icons.menu_book, Color(0xFF9C27B0), '/crop-guide'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: actions.length,
          itemBuilder: (_, index) {
            final a = actions[index];
            return Card(
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, a.route),
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(color: a.color.withOpacity(0.1), shape: BoxShape.circle),
                        child: Icon(a.icon, color: a.color, size: 28),
                      ),
                      SizedBox(height: 12),
                      Text(a.title, style: TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCropStatus() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Crop Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            _buildCropItem('Wheat Field A', 'Healthy', 0.85, Colors.green),
            _buildCropItem('Rice Field B', 'Needs Water', 0.65, Colors.orange),
            _buildCropItem('Corn Field C', 'Excellent', 0.95, Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildCropItem(String name, String status, double progress, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.w600)),
              Text(status, style: TextStyle(color: color, fontSize: 12)),
            ],
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketPrices() {
    final prices = [
      MarketPrice('Wheat', 245, 2.5),
      MarketPrice('Rice', 312, -1.2),
      MarketPrice('Corn', 189, 4.1),
    ];
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Market Prices', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Live', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
            SizedBox(height: 16),
            ...prices.map((p) => _buildPriceItem(p)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceItem(MarketPrice p) {
    final isPos = p.change >= 0;
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(p.commodity, style: TextStyle(fontWeight: FontWeight.w600)),
          Row(
            children: [
              Text('\$${p.price}/ton', style: TextStyle(fontSize: 16)),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (isPos ? Colors.green : Colors.red).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(isPos ? Icons.arrow_upward : Icons.arrow_downward, size: 12, color: isPos ? Colors.green : Colors.red),
                    Text('${p.change.abs().toStringAsFixed(1)}%', style: TextStyle(color: isPos ? Colors.green : Colors.red, fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Disease Detector Screen
class DiseaseDetectorScreen extends StatefulWidget {
  @override
  _DiseaseDetectorScreenState createState() => _DiseaseDetectorScreenState();
}

class _DiseaseDetectorScreenState extends State<DiseaseDetectorScreen> {
  bool _isScanning = false;
  DetectionResult? _lastResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Disease Detection'),
        actions: [
          IconButton(icon: Icon(Icons.history), onPressed: () => _showScanHistory()),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[300]!, width: 2),
              ),
              child: _isScanning ? _buildScanningView() : _buildCameraView(),
            ),
          ),
          if (_lastResult != null) _buildResultCard(),
          _buildActionButtons(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildCameraView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.camera_alt, size: 80, color: Colors.grey[400]),
        SizedBox(height: 16),
        Text('Position your plant leaf in the camera', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Text('Make sure the leaf is well-lit and in focus', style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildScanningView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
              ),
            ),
            Icon(Icons.search, size: 40, color: Theme.of(context).colorScheme.primary),
          ],
        ),
        SizedBox(height: 24),
        Text('Analyzing plant...', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Text('This may take a few seconds', style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildResultCard() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _lastResult!.isHealthy ? Icons.check_circle : Icons.warning,
                    color: _lastResult!.isHealthy ? Colors.green : Colors.orange,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(_lastResult!.condition, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 12),
              LinearProgressIndicator(
                value: _lastResult!.confidence,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(_lastResult!.isHealthy ? Colors.green : Colors.orange),
              ),
              SizedBox(height: 8),
              Text('Confidence: ${(_lastResult!.confidence * 100).toInt()}%'),
              if (!_lastResult!.isHealthy) ...[
                SizedBox(height: 16),
                Text('Recommended Treatment:', style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text(_lastResult!.treatment),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _selectFromGallery(),
              icon: Icon(Icons.photo_library),
              label: Text('Gallery'),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: _isScanning ? null : () => _startScanning(),
              icon: Icon(Icons.camera_alt),
              label: Text(_isScanning ? 'Analyzing...' : 'Scan Plant'),
              style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 12)),
            ),
          ),
        ],
      ),
    );
  }

  void _startScanning() async {
    setState(() {
      _isScanning = true;
      _lastResult = null;
    });
    await Future.delayed(Duration(seconds: 3));
    final random = Random();
    final conditions = [
      DetectionResult('Healthy Plant', true, 0.95, ''),
      DetectionResult('Leaf Spot Disease', false, 0.87, 'Apply fungicide spray every 7 days'),
      DetectionResult('Nutrient Deficiency', false, 0.82, 'Apply balanced fertilizer and ensure proper watering'),
      DetectionResult('Pest Damage', false, 0.78, 'Use organic pesticide and remove affected leaves'),
    ];
    setState(() {
      _isScanning = false;
      _lastResult = conditions[random.nextInt(conditions.length)];
    });
    HapticFeedback.mediumImpact();
  }

  void _selectFromGallery() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gallery feature coming soon!')));
  }

  void _showScanHistory() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Scan history coming soon!')));
  }
}

// Weather Screen
class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  WeatherData _currentWeather = WeatherData();
  Timer? _updateTimer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _startWeatherUpdates();
  }

  void _startWeatherUpdates() {
    _updateTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() => _currentWeather.updateRandomData());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Today'),
            Tab(text: '7 Days'),
            Tab(text: 'Alerts'),
          ],
        ),
        actions: [IconButton(icon: Icon(Icons.location_on), onPressed: () {})],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTodayView(),
          _buildWeeklyView(),
          _buildAlertsView(),
        ],
      ),
    );
  }

  Widget _buildTodayView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCurrentWeatherCard(),
          SizedBox(height: 16),
          _buildHourlyForecast(),
          SizedBox(height: 16),
          _buildWeatherDetails(),
          SizedBox(height: 16),
          _buildAgricultureAdvice(),
        ],
      ),
    );
  }

  Widget _buildWeeklyView() {
    final days = List.generate(7, (index) {
      final date = DateTime.now().add(Duration(days: index));
      return DailyWeather(date, 25 + Random().nextInt(10), 15 + Random().nextInt(10), Icons.wb_sunny, 'Sunny');
    });
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: days.length,
      itemBuilder: (_, index) {
        final day = days[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(day.icon, color: Colors.orange),
            title: Text('${day.date.day}/${day.date.month}/${day.date.year}'),
            subtitle: Text(day.condition),
            trailing: Text('${day.maxTemp}° / ${day.minTemp}°'),
          ),
        );
      },
    );
  }

  Widget _buildAlertsView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('No alerts', style: TextStyle(fontSize: 18)),
      ),
    );
  }

  Widget _buildCurrentWeatherCard() {
    return Card(
      elevation: 4,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[400]!, Colors.blue[600]!],
          ),
        ),
        child: Column(
          children: [
            Text('Vijayawada', style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 8),
            Icon(_currentWeather.getWeatherIcon(), size: 80, color: Colors.white),
            SizedBox(height: 16),
            Text('${_currentWeather.temperature}°C', style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w300)),
            Text(_currentWeather.condition, style: TextStyle(color: Colors.white70, fontSize: 18)),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildWeatherStat('Feels Like', '${_currentWeather.temperature + 2}°C'),
                _buildWeatherStat('Humidity', '${_currentWeather.humidity}%'),
                _buildWeatherStat('Wind', '${_currentWeather.windSpeed} km/h'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.white)),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
      ],
    );
  }

  Widget _buildHourlyForecast() {
    final hours = List.generate(12, (index) {
      final hour = DateTime.now().add(Duration(hours: index));
      return HourlyWeather(hour.hour, 25 + Random().nextInt(10), Icons.wb_sunny);
    });
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hourly Forecast', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hours.length,
                itemBuilder: (_, index) {
                  final h = hours[index];
                  return Container(
                    width: 70,
                    margin: EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        Text('${h.hour}:00', style: TextStyle(fontSize: 12)),
                        SizedBox(height: 8),
                        Icon(h.icon, color: Colors.orange, size: 24),
                        SizedBox(height: 8),
                        Text('${h.temperature}°', style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetails() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Weather Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 3,
              children: [
                _buildDetailItem(Icons.visibility, 'Visibility', '10 km'),
                _buildDetailItem(Icons.compress, 'Pressure', '1013 hPa'),
                _buildDetailItem(Icons.water_drop, 'Dew Point', '18°C'),
                _buildDetailItem(Icons.wb_sunny, 'UV Index', '6 (High)'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 12)),
            Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  Widget _buildAgricultureAdvice() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.agriculture, color: Theme.of(context).colorScheme.primary),
                SizedBox(width: 8),
                Text('Agricultural Advice', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 16),
            _buildAdviceItem(Icons.water_drop, 'Irrigation', 'Good conditions for watering crops'),
            _buildAdviceItem(Icons.grass, 'Field Work', 'Ideal weather for field operations'),
            _buildAdviceItem(Icons.warning, 'Alert', 'No weather warnings for your area'),
          ],
        ),
      ),
    );
  }

  Widget _buildAdviceItem(IconData icon, String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.green),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
                Text(description, style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Market Screen
class MarketScreen extends StatefulWidget {
  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  Timer? _timer;
  List<MarketPrice> _prices = [
    MarketPrice('Wheat', 245, 2.5),
    MarketPrice('Rice', 312, -1.2),
    MarketPrice('Corn', 189, 4.1),
    MarketPrice('Cotton', 156, 0.8),
    MarketPrice('Soybean', 278, -2.1),
    MarketPrice('Sugarcane', 89, 1.5),
  ];

  @override
  void initState() {
    super.initState();
    _startPriceUpdates();
  }

  void _startPriceUpdates() {
    _timer = Timer.periodic(Duration(seconds: 10), (_) {
      setState(() {
        _prices.forEach((p) => p.updateRandomly());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Market Prices'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _prices.forEach((p) => p.updateRandomly());
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Price alerts coming soon!')));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildMarketSummary(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _prices.length,
              itemBuilder: (_, index) => _buildPriceCard(_prices[index]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sell Crop coming soon!')));
        },
        icon: Icon(Icons.sell),
        label: Text('Sell Crop'),
      ),
    );
  }

  Widget _buildMarketSummary() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.green[400]!, Colors.green[600]!]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('Active', '${_prices.length}', Icons.trending_up),
          _buildSummaryItem('Up', '${_prices.where((p) => p.change >= 0).length}', Icons.arrow_upward),
          _buildSummaryItem('Down', '${_prices.where((p) => p.change < 0).length}', Icons.arrow_downward),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        SizedBox(height: 8),
        Text(value, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildPriceCard(MarketPrice p) {
    final isPos = p.change >= 0;
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(p.commodity, style: TextStyle(fontWeight: FontWeight.w600)),
          Row(
            children: [
              Text('\$${p.price}/ton', style: TextStyle(fontSize: 16)),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (isPos ? Colors.green : Colors.red).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(isPos ? Icons.arrow_upward : Icons.arrow_downward, size: 12, color: isPos ? Colors.green : Colors.red),
                    Text('${p.change.abs().toStringAsFixed(1)}%', style: TextStyle(color: isPos ? Colors.green : Colors.red, fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// Crop Guide Screen
class CropGuideScreen extends StatelessWidget {
  final List<CropInfo> crops = [
    CropInfo('Wheat', Icons.grass, 'Rabi crop, sown in winter', Colors.amber),
    CropInfo('Rice', Icons.grain, 'Kharif crop, needs plenty of water', Colors.green),
    CropInfo('Corn', Icons.agriculture, 'Kharif crop, high nutritional value', Colors.orange),
    CropInfo('Cotton', Icons.local_florist, 'Cash crop, needs warm climate', Colors.pink),
    CropInfo('Sugarcane', Icons.ac_unit, 'Long duration crop, high water needs', Colors.brown),
    CropInfo('Soybean', Icons.eco, 'Protein-rich legume crop', Colors.green.shade700),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Guide'),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: crops.length,
        itemBuilder: (_, index) {
          final crop = crops[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () => _showCropDetails(context, crop),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(crop.icon, color: crop.color, size: 40),
                    SizedBox(width: 20),
                    Text(crop.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCropDetails(BuildContext ctx, CropInfo crop) {
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        title: Text(crop.name),
        content: Text('Details about ${crop.name}.\n\n${crop.description}'),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Close'))],
      ),
    );
  }
}

// Profile Screen
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Name: John Doe'),
            SizedBox(height: 8),
            Text('Email: john.doe@example.com'),
            SizedBox(height: 8),
            Text('Phone: +1234567890'),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Edit Profile feature coming soon!')));
              },
              child: Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Settings Screen
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            ListTile(
              title: Text('Language'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.pushNamed(context, '/language'),
            ),
            ListTile(
              title: Text('Notifications'),
              trailing: Switch(value: true, onChanged: (val) {}),
            ),
            ListTile(
              title: Text('Theme'),
              trailing: DropdownButton<String>(
                value: 'System',
                items: ['System', 'Light', 'Dark'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {},
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

// Data Models
class LanguageOption {
  final String name;
  final String flag;
  final String code;
  LanguageOption(this.name, this.flag, this.code);
}

class MarketPrice {
  final String commodity;
  int price;
  double change;
  MarketPrice(this.commodity, this.price, this.change);
  void updateRandomly() {
    final delta = (Random().nextDouble() * 5) * (Random().nextBool() ? 1 : -1);
    change += delta;
    price += delta.toInt();
  }
}

class DetectionResult {
  final String condition;
  final bool isHealthy;
  final double confidence;
  final String treatment;
  DetectionResult(this.condition, this.isHealthy, this.confidence, this.treatment);
}

class WeatherData {
  int temperature = 25;
  int humidity = 60;
  int windSpeed = 10;
  String condition = 'Clear';

  IconData getWeatherIcon() {
    if (condition.contains('Cloud')) return Icons.cloud;
    if (condition.contains('Rain')) return Icons.beach_access;
    if (condition.contains('Sunny')) return Icons.wb_sunny;
    if (condition.contains('Clear')) return Icons.wb_sunny;
    return Icons.help_outline;
  }

  void updateRandomData() {
    temperature = 20 + Random().nextInt(15);
    humidity = 50 + Random().nextInt(50);
    windSpeed = 5 + Random().nextInt(20);
    final conds = ['Clear', 'Partly Cloudy', 'Rainy', 'Sunny'];
    condition = conds[Random().nextInt(conds.length)];
  }
}

class HourlyWeather {
  final int hour;
  final int temperature;
  final IconData icon;
  HourlyWeather(this.hour, this.temperature, this.icon);
}

class DailyWeather {
  final DateTime date;
  final int maxTemp;
  final int minTemp;
  final IconData icon;
  final String condition;
  DailyWeather(this.date, this.maxTemp, this.minTemp, this.icon, this.condition);
}

class CropInfo {
  final String name;
  final IconData icon;
  final String description;
  final Color color;
  CropInfo(this.name, this.icon, this.description, this.color);
}

class QuickAction {
  final String title;
  final IconData icon;
  final Color color;
  final String route;
  QuickAction(this.title, this.icon, this.color, this.route);
}