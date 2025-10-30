import 'package:flutter/material.dart';
import 'package:moneyproject/main.dart';
import 'package:moneyproject/screens/home_screen.dart';

void main() {
  runApp(PasswordScreen());
}

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'passwardscreen', home: const PasswordInput());
  }
}

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key});

  @override
  State<PasswordInput> createState() => _PasswardInputState();
}

class _PasswardInputState extends State<PasswordInput> {
  final TextEditingController _controller = TextEditingController();
  bool _obscureText = true; //パスワードの表示非表示

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkPassword() {
    final password = _controller.text;
    if (password == "1234") {
      //TODO
      //のちにユーザのパスワードを受け付ける
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("パスワードが違います")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('パスワード入力')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: 'パスワード',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkPassword,
              child: const Text('ログイン'),
            ),
          ],
        ),
      ),
    );
  }
}
