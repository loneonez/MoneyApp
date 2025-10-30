import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';
import 'package:moneyproject/screens/password_screen.dart';
import 'package:flutter/material.dart';
import 'package:moneyproject/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const Startscreen());
  }
}

class Startscreen extends StatefulWidget {
  const Startscreen({super.key});

  @override
  State<Startscreen> createState() => _StartscreenState();
}

class _StartscreenState extends State<Startscreen> {
  @override
  void initState() {
    super.initState();
    // 🔹2秒後に画面遷移！
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PasswordScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_balance, size: 48, color: Colors.green),
          const Text('タイトル名', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
