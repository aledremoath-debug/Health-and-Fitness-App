import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'utils/app_theme.dart';
import 'screens/dashboard_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/settings_screen.dart';
import 'widgets/app_navbar.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const VitalityAI());
}

class VitalityAI extends StatelessWidget {
  const VitalityAI({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: Consumer<UserProvider>(
        builder: (context, provider, _) {
          return MaterialApp(
            title: 'VitalityAI',
            debugShowCheckedModeBanner: false,
            theme: provider.isDark ? AppTheme.darkTheme() : AppTheme.lightTheme(),
            home: const MainShell(),
          );
        },
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController();
  // Track which pages have been visited to enable lazy loading
  final Set<int> _loadedPages = {0};

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildPage(int index) {
    // Only build pages that have been visited (lazy loading)
    if (!_loadedPages.contains(index)) {
      return const SizedBox.shrink();
    }
    switch (index) {
      case 0:
        return DashboardScreen(scrollController: _scrollController);
      case 1:
        return const ReportsScreen();
      case 2:
        return const SettingsScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppNavbar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _loadedPages.add(index);
              _currentIndex = index;
            });
          },
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: List.generate(3, _buildPage),
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 768
          ? AppBottomNav(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _loadedPages.add(index);
                  _currentIndex = index;
                });
              },
            )
          : null,
    );
  }
}
