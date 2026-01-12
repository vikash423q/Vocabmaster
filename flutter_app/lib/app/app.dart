import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_router.dart';
import 'theme/app_theme.dart';
import '../core/services/notification_service.dart';

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
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _loadThemeMode();
    await _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    // Initialize notification service
    await NotificationService().initialize();
    
    // Restore scheduled notifications if they were enabled
    final prefs = await SharedPreferences.getInstance();
    final notificationsEnabled = prefs.getBool('notifications_enabled') ?? false;
    if (notificationsEnabled) {
      final hour = prefs.getInt('notification_hour') ?? 9;
      final minute = prefs.getInt('notification_minute') ?? 0;
      await NotificationService().scheduleReviewReminder(
        hour: hour,
        minute: minute,
        enabled: true,
      );
    }
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
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'VocabMaster',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeMode,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: AppRouter.splash,
        );
      },
    );
  }
}
