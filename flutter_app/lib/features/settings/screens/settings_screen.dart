import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../../app/app_router.dart';
import '../../../app/app.dart';
import '../../../core/services/notification_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkModeEnabled = true;
  bool _notificationsEnabled = false;
  TimeOfDay _notificationTime = const TimeOfDay(hour: 9, minute: 0);
  bool _storyNotificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkModeEnabled = prefs.getBool('dark_mode') ?? true;
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? false;
      _storyNotificationsEnabled = prefs.getBool('story_notifications_enabled') ?? false;
      final hour = prefs.getInt('notification_hour') ?? 9;
      final minute = prefs.getInt('notification_minute') ?? 0;
      _notificationTime = TimeOfDay(hour: hour, minute: minute);
    });
    
    // Restore scheduled notifications if enabled
    if (_notificationsEnabled) {
      final notificationService = NotificationService();
      await notificationService.initialize();
      await notificationService.scheduleReviewReminder(
        hour: _notificationTime.hour,
        minute: _notificationTime.minute,
        enabled: true,
      );
    }
  }

  Future<void> _saveDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', value);
    setState(() {
      _darkModeEnabled = value;
    });
    // Update app theme
    final appState = VocabMasterAppState.instance;
    if (appState != null) {
      appState.updateThemeMode(value ? ThemeMode.dark : ThemeMode.light);
    }
  }

  Future<void> _saveNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', value);
    setState(() {
      _notificationsEnabled = value;
    });
    
    // Schedule or cancel notifications
    final notificationService = NotificationService();
    await notificationService.scheduleReviewReminder(
      hour: _notificationTime.hour,
      minute: _notificationTime.minute,
      enabled: value,
    );
  }

  Future<void> _saveStoryNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('story_notifications_enabled', value);
    setState(() {
      _storyNotificationsEnabled = value;
    });
    // TODO: Schedule/cancel story notifications
  }

  Future<void> _selectNotificationTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _notificationTime,
    );
    if (picked != null && picked != _notificationTime) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('notification_hour', picked.hour);
      await prefs.setInt('notification_minute', picked.minute);
      setState(() {
        _notificationTime = picked;
      });
      
      // Reschedule notifications with new time if enabled
      if (_notificationsEnabled) {
        final notificationService = NotificationService();
        await notificationService.scheduleReviewReminder(
          hour: picked.hour,
          minute: picked.minute,
          enabled: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.settings_rounded),
            const SizedBox(width: 8),
            const Text(
              'Settings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          // User profile section
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                final user = state.user;
                return Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Profile',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Username'),
                          subtitle: Text(user.username),
                        ),
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: const Text('Email'),
                          subtitle: Text(user.email),
                        ),
                        if (user.currentLevel != null)
                          ListTile(
                            leading: const Icon(Icons.trending_up),
                            title: const Text('Vocabulary Level'),
                            subtitle: Text(
                              '${user.currentLevel!.toStringAsFixed(1)} / 10.0',
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          // App settings
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'App Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode),
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Use dark theme'),
                  value: _darkModeEnabled,
                  onChanged: (value) {
                    _saveDarkMode(value);
                    // Update theme immediately
                    final app = context.findAncestorWidgetOfExactType<MaterialApp>();
                    if (app != null) {
                      // Force rebuild with new theme
                      (context as Element).markNeedsBuild();
                    }
                  },
                ),
                const Divider(),
                SwitchListTile(
                  secondary: const Icon(Icons.notifications),
                  title: const Text('Daily Review Reminders'),
                  subtitle: const Text('Get notified to review your words'),
                  value: _notificationsEnabled,
                  onChanged: _saveNotifications,
                ),
                if (_notificationsEnabled) ...[
                  ListTile(
                    leading: const Icon(Icons.access_time),
                    title: const Text('Notification Time'),
                    subtitle: Text(_notificationTime.format(context)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _selectNotificationTime,
                  ),
                ],
                const Divider(),
                SwitchListTile(
                  secondary: const Icon(Icons.auto_stories),
                  title: const Text('Story Notifications'),
                  subtitle: const Text('Get notified when new stories are ready'),
                  value: _storyNotificationsEnabled,
                  onChanged: _saveStoryNotifications,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Help & Info
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Help & Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('How This Works?'),
              subtitle: const Text('Learn about VocabMaster\'s features'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, AppRouter.howItWorks);
              },
            ),
          ),
          const SizedBox(height: 16),
          // Account actions
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(LogoutRequested());
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRouter.login,
                            (route) => false,
                          );
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32),
          // Footer
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Developed by Vikash Kumar Gaurav',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
