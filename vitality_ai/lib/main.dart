import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'utils/app_theme.dart';
import 'screens/dashboard_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/settings_screen.dart';
import 'widgets/app_navbar.dart';

void main() {
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppNavbar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          DashboardScreen(scrollController: _scrollController),
          const ReportsScreen(),
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 768
          ? AppBottomNav(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() => _currentIndex = index);
              },
            )
          : null,
    );
  }
}
