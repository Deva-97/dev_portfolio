import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'app_routes.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/ninaivu_delete_account_page.dart';
import 'presentation/screens/ninaivu_privacy_policy_page.dart';
import 'presentation/screens/splash_screen.dart';

void main() {
  usePathUrlStrategy();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  bool _showSplash = true;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void _onSplashComplete() {
    setState(() {
      _showSplash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Devendiran Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      themeAnimationDuration: const Duration(milliseconds: 400),
      themeAnimationCurve: Curves.easeInOut,
      routes: {
        AppRoutes.home: (context) => _showSplash
            ? SplashScreen(onComplete: _onSplashComplete)
            : HomeScreen(
                onToggleTheme: toggleTheme,
                themeMode: _themeMode,
              ),
        AppRoutes.ninaivuPrivacyPolicy: (context) =>
            const NinaivuPrivacyPolicyPage(),
        AppRoutes.ninaivuDeleteAccount: (context) =>
            const NinaivuDeleteAccountPage(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => _showSplash
            ? SplashScreen(onComplete: _onSplashComplete)
            : HomeScreen(
                onToggleTheme: toggleTheme,
                themeMode: _themeMode,
              ),
      ),
    );
  }
}
