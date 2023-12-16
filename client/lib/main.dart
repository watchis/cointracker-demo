import 'package:client/components/app_manager.dart';
import 'package:client/utils/app_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinTracker Demo',
      theme: _buildTheme(),
      home: const AppManager(initialPage: AppPage.home),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.blue.shade200,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Colors.blue,
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
    );
  }
}
