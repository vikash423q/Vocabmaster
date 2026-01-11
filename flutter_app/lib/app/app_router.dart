import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/auth/bloc/auth_bloc.dart';
import '../features/daily_review/screens/daily_stack_screen.dart';
import '../features/word_detail/screens/comprehensive_review_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String dailyReview = '/daily-review';
  static const String wordDetail = '/word-detail';
  static const String addWords = '/add-words';
  static const String progress = '/progress';
  static const String guidedStory = '/guided-story';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => AuthBloc(),
            child: const LoginScreen(),
          ),
        );
      case register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => AuthBloc(),
            child: const RegisterScreen(),
          ),
        );
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case dailyReview:
        return MaterialPageRoute(builder: (_) => const DailyStackScreen());
      case wordDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        final wordId = args?['wordId'] as int? ?? 0;
        return MaterialPageRoute(
          builder: (_) => ComprehensiveReviewScreen(wordId: wordId),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

// Splash Screen with navigation logic
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a small delay to ensure BLoC is ready, then check auth
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        final authBloc = context.read<AuthBloc>();
        if (authBloc.state is AuthInitial) {
          authBloc.add(CheckAuthStatus());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // Navigate to home if authenticated
          Navigator.of(context).pushReplacementNamed(AppRouter.home);
        } else if (state is AuthUnauthenticated || state is AuthError) {
          // Navigate to login if not authenticated
          Navigator.of(context).pushReplacementNamed(AppRouter.login);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'VocabMaster',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthError) {
                    return Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    );
                  }
                  return const Text('Loading...');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('VocabMaster')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.dailyReview);
              },
              child: const Text('Daily Review'),
            ),
          ],
        ),
      ),
    );
  }
}
