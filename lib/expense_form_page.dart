import 'package:flutter/material.dart';

class ExpenseFormPage extends StatefulWidget {
  const ExpenseFormPage({super.key});

  @override
  State<ExpenseFormPage> createState() => _ExpenseFormPageState();
}

class _ExpenseFormPageState extends State<ExpenseFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedCategory;
  final List<String> _categories = ['Ulaşım', 'Yemek', 'Konaklama', 'Diğer'];

  @override
  void dispose() {
    _amountController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 2),
      locale: const Locale('tr', 'TR'),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showMockPhotoMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mock: Fotoğraf ekleme henüz aktif değil.')),
    );
  }

  void _saveExpense() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masraf kaydedildi (mock)!')),
      );
      // Formu temizle (isteğe bağlı)
      setState(() {
        _amountController.clear();
        _descController.clear();
        _selectedDate = null;
        _selectedCategory = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masraf Girişi'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Tutar',
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tutar giriniz';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Geçerli bir sayı giriniz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Açıklama',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Açıklama giriniz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _pickDate,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Tarih',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.date_range),
                        ),
                        child: Text(
                          _selectedDate == null
                              ? 'Tarih seçiniz'
                              : '${_selectedDate!.day}.${_selectedDate!.month}.${_selectedDate!.year}',
                          style: TextStyle(
                            color: _selectedDate == null
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    tooltip: 'Fiş/Fotoğraf Ekle (Mock)',
                    onPressed: _showMockPhotoMessage,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: _categories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedCategory = val;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kategori seçiniz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Kaydet'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: _saveExpense,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 