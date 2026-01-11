import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_router.dart';
import 'theme/app_theme.dart';

class VocabMasterApp extends StatefulWidget {
  const VocabMasterApp({super.key});

  @override
  State<VocabMasterApp> createState() => VocabMasterAppState();
}

class VocabMasterAppState extends State<VocabMasterApp> {
  static VocabMasterAppState? _instance;
  ThemeMode _themeMode = ThemeMode.dark;

  VocabMasterAppState() {
    _instance = this;
  }

  static VocabMasterAppState? get instance => _instance;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final darkMode = prefs.getBool('dark_mode') ?? true;
    if (mounted) {
      setState(() {
        _themeMode = darkMode ? ThemeMode.dark : ThemeMode.light;
      });
    }
  }

  void updateThemeMode(ThemeMode mode) {
    if (mounted) {
      setState(() {
        _themeMode = mode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VocabMaster',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.splash,
    );
  }
}
