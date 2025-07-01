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

  void _showSnackBar(BuildContext context, String message, Color color, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Text(
              message,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Masraf Onay', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        elevation: 0.5,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: _mockExpenses.length,
        itemBuilder: (context, index) {
          final expense = _mockExpenses[index];
          final Color cardColor = Colors.blue[700]!;
          final IconData cardIcon = expense['category'] == 'Yemek'
              ? Icons.restaurant
              : expense['category'] == 'Ulaşım'
                  ? Icons.directions_car
                  : expense['category'] == 'Konaklama'
                      ? Icons.hotel
                      : Icons.receipt;
          return Container(
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: cardColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Icon(cardIcon, color: cardColor, size: 32),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '${expense['amount']} TL',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: cardColor,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${expense['date'].day}.${expense['date'].month}.${expense['date'].year}',
                        style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    expense['desc'],
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 44,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.check),
                          label: const Text('Onayla', style: TextStyle(fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[600],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () => _showSnackBar(context, 'Masraf onaylandı!', Colors.green[700]!, Icons.check_circle),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        height: 44,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.close),
                          label: const Text('Reddet', style: TextStyle(fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[600],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () => _showSnackBar(context, 'Masraf reddedildi!', Colors.red[700]!, Icons.cancel),
                        ),
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