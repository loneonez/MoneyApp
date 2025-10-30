import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('設定'), backgroundColor: Colors.green),
      body: const Center(
        child: Text('ここに設定項目を追加していくよ🛠️', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
