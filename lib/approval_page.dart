import 'package:flutter/material.dart';

class ApprovalPage extends StatelessWidget {
  const ApprovalPage({super.key});

  // Mock masraf verileri
  List<Map<String, dynamic>> get _mockExpenses => [
        {
          'amount': 250.0,
          'desc': 'Yemek (iş yemeği)',
          'date': DateTime(2024, 6, 1),
          'category': 'Yemek',
        },
        {
          'amount': 120.5,
          'desc': 'Taksi',
          'date': DateTime(2024, 6, 2),
          'category': 'Ulaşım',
        },
        {
          'amount': 800.0,
          'desc': 'Otel konaklama',
          'date': DateTime(2024, 6, 3),
          'category': 'Konaklama',
        },
      ];

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masraf Onay'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _mockExpenses.length,
        itemBuilder: (context, index) {
          final expense = _mockExpenses[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 20),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        expense['category'] == 'Yemek'
                            ? Icons.restaurant
                            : expense['category'] == 'Ulaşım'
                                ? Icons.directions_car
                                : expense['category'] == 'Konaklama'
                                    ? Icons.hotel
                                    : Icons.receipt,
                        color: Colors.deepPurple,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${expense['amount']} TL',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${expense['date'].day}.${expense['date'].month}.${expense['date'].year}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    expense['desc'],
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.check),
                        label: const Text('Onayla'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => _showSnackBar(context, 'Masraf onaylandı!'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.close),
                        label: const Text('Reddet'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => _showSnackBar(context, 'Masraf reddedildi!'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 