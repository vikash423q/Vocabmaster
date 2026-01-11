import 'package:flutter/material.dart';
import '../../daily_review/screens/daily_stack_screen.dart';
import '../../progress/screens/progress_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../../ai/screens/ai_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0; // Review is default (center)

  final List<Widget> _screens = [
    const DailyStackScreen(), // Review (index 0)
    const ProgressScreen(),   // Progress (index 1)
    const AiScreen(),          // AI (index 2)
    const SettingsScreen(),    // Settings (index 3 - last)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey[600],
          selectedFontSize: 13,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 0 ? Icons.book : Icons.book_outlined,
              ),
              activeIcon: Icon(
                Icons.book,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: 'Review',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 1 ? Icons.trending_up_rounded : Icons.trending_up_outlined,
              ),
              activeIcon: Icon(
                Icons.trending_up_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 2 ? Icons.auto_awesome_rounded : Icons.auto_awesome_outlined,
              ),
              activeIcon: Icon(
                Icons.auto_awesome_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: 'AI',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 3 ? Icons.settings_rounded : Icons.settings_outlined,
              ),
              activeIcon: Icon(
                Icons.settings_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
