import 'package:flutter/material.dart';
import 'expense_form_page.dart'; // pendingExpenses ve approvedExpenses için

class ApprovalPage extends StatefulWidget {
  const ApprovalPage({super.key});

  @override
  State<ApprovalPage> createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _approveExpense(int index) {
    setState(() {
      final expense = pendingExpenses[index];
      approvedExpenses.add({...expense, 'status': 'Approved'});
      pendingExpenses.removeAt(index);
    });
    _showSnackBar(context, 'Masraf onaylandı!');
  }

  void _rejectExpense(int index) {
    setState(() {
      pendingExpenses.removeAt(index);
    });
    _showSnackBar(context, 'Masraf reddedildi!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Reports"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: pendingExpenses.isEmpty
          ? const Center(child: Text('Onay bekleyen masraf yok.'))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: pendingExpenses.length,
              itemBuilder: (context, index) {
                final expense = pendingExpenses[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.orange.shade100,
                                child: const Icon(
                                  Icons.receipt_long,
                                  color: Colors.orange,
                                ),
                                radius: 28,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      expense['title'] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      expense['date'] != null
                                          ? 'Submitted on ${expense['date'].toString().split(' ')[0]}'
                                          : '',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.more_vert, color: Colors.grey),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            expense['amount'] != null
                                ? '\$${expense['amount']}'
                                : '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            expense['status'] ?? '',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () => _rejectExpense(index),
                                icon: const Icon(
                                  Icons.thumb_down,
                                  color: Colors.red,
                                ),
                                label: const Text(
                                  'Reject',
                                  style: TextStyle(color: Colors.red),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red.withOpacity(0.08),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              TextButton.icon(
                                onPressed: () => _approveExpense(index),
                                icon: const Icon(
                                  Icons.thumb_up,
                                  color: Colors.green,
                                ),
                                label: const Text(
                                  'Approve',
                                  style: TextStyle(color: Colors.green),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green.withOpacity(
                                    0.08,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
