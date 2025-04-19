import 'package:flutter/material.dart';
import 'package:talkie_tool/screens/home_screen.dart';
import 'package:talkie_tool/screens/login_screen.dart';
import 'package:talkie_tool/screens/signup_screen.dart';
import 'package:talkie_tool/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  Map<String, String> _user = {};

  // Function to update theme
  void updateTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  // Function to log in user
  void loginUser(String email, String username) {
    setState(() {
      _user = {'email': email, 'username': username};
    });
  }

  // Function to log out user and redirect to login screen
  void logoutUser() {
    setState(() {
      _user = {}; // Clear user data on logout
    });
    Navigator.pushReplacementNamed(context, '/login'); // Navigate to the login screen
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talkie Tool',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (_) => HomeScreen(
          user: _user,
          onThemeChange: updateTheme,
          onLogout: logoutUser, // Pass logout callback here
        ),
        '/login': (_) => LoginScreen(onLogin: loginUser),
        '/signup': (_) => SignupScreen(onSignup: loginUser),
      },
    );
  }
}
