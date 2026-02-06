import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  String type = 'deposit';
  String category = 'sukarela';
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Transaksi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //PILIH TIPE
            DropdownButtonFormField<String>(
              value: type,
              items: const [
                DropdownMenuItem(value: 'deposit', child: Text('Deposit')),
                DropdownMenuItem(value: 'withdraw', child: Text('Withdraw')),
              ],
              onChanged: (value) {
                setState(() => type = value!);
              },
              decoration: const InputDecoration(labelText: 'Tipe Transaksi'),
            ),

            const SizedBox(height: 16),

            //KATEGORI
            DropdownButtonFormField<String>(
              value: category,
              items: const [
                DropdownMenuItem(value: 'wajib', child: Text('Simpanan Wajib')),
                DropdownMenuItem(
                  value: 'sukarela',
                  child: Text('Simpanan Sukarela'),
                ),
              ],
              onChanged: (v) => setState(() => category = v!),
              decoration: const InputDecoration(labelText: 'Kategori'),
            ),
            const SizedBox(height: 16),

            //JUDUL
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Judul Transaksi'),
            ),

            const SizedBox(height: 16),

            //NOMINAL
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Nominal'),
            ),

            const SizedBox(height: 32),

            //BUAT PILIH TANGGAL
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );

                if (picked != null) {
                  setState(() => selectedDate = picked);
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Tanggal Transaksi',
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  '${selectedDate.day.toString().padLeft(2, '0')}-'
                  '${selectedDate.month.toString().padLeft(2, '0')}-'
                  '${selectedDate.year}',
                ),
              ),
            ),

            // SIMPAN
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final amount = double.tryParse(amountController.text);

                  if (amount == null || amount <= 0) return;

                  try {
                    context.read<HomeProvider>().addTransaction({
                      "type": type,
                      "category": category,
                      "title": titleController.text,
                      "date": selectedDate.toIso8601String(),
                      "amount": amount,
                    });

                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child: const Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
