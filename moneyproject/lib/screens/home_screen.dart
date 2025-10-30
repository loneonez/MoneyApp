// ...元のコードに戻すので何も追加しません
import 'package:flutter/material.dart';
import 'package:moneyproject/main.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SavingsScreen(),
    );
  }
}

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('設定'), backgroundColor: Colors.green),
      body: const Center(child: Text('設定画面です')),
    );
  }
}

class SavingsScreen extends StatefulWidget {
  const SavingsScreen({super.key});

  @override
  State<SavingsScreen> createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen> {
  int _selectedIndex = 0; // 現在のタブ
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  double totalSavings = 0;
  final List<Map<String, dynamic>> _transactions = [];

  static const List<Widget> _pages = <Widget>[
    Center(child: Text('🏠 ホーム', style: TextStyle(fontSize: 24))),
    Center(child: Text('📄 明細', style: TextStyle(fontSize: 24))),
    Center(child: Text('📝 リスト', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addTransaction() {
    final entered = double.tryParse(_amountController.text);
    if (entered != null) {
      setState(() {
        totalSavings += entered;
        _transactions.insert(0, {
          'amount': entered,
          'memo': _memoController.text,
          'time': DateTime.now(),
        });
      });
      _amountController.clear();
      _memoController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingScreen()),
            );
          },
        ),
        backgroundColor: Colors.green,
      ),
      //body===========================================-
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.greenAccent, Colors.white], // ← ここで上緑→下白のグラデーション✨
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '現在の貯金額：',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '¥${totalSavings.toStringAsFixed(0)}', // ← ここでtotalSavingsを表示！
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: totalSavings >= 0 ? Colors.black : Colors.red,
                    ),
                  ),
                ],
              ),

              const Divider(), //横線を引くためのwidget
              Expanded(
                child: ListView.builder(
                  itemCount: _transactions.length,
                  itemBuilder: (context, index) {
                    final t = _transactions[index];
                    final sign = t['amount'] >= 0 ? '💰' : '💸';
                    final color = t['amount'] >= 0 ? Colors.black : Colors.red;
                    return ListTile(
                      title: Text(
                        '$sign¥${t['amount'].abs().toStringAsFixed(0)}',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(t['memo']),
                      trailing: Text(
                        '${t['time'].hour}:${t['time'].minute.toString().padLeft(2, '0')}',
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '金額を入力（マイナスもOK）',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _memoController,
                decoration: const InputDecoration(
                  labelText: '詳細メモ（例：ゆうちょ→学費）',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTransaction,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: '明細'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'メニュ一覧'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}
