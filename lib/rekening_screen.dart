import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RekeningBankScreen extends StatefulWidget {
  const RekeningBankScreen({super.key});

  @override
  State<RekeningBankScreen> createState() => _RekeningBankScreenState();
}

class _RekeningBankScreenState extends State<RekeningBankScreen> {
  final bankController = TextEditingController(text: 'BCA');
  final rekeningController = TextEditingController(text: '3456709997');
  final namaController = TextEditingController(text: 'User');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Rekening Bank'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _input(
              label: 'Nama Bank',
              controller: bankController,
              dropdown: true,
            ),
            const SizedBox(height: 12),
            _input(label: 'Nomor Rekening', controller: rekeningController),
            const SizedBox(height: 12),
            _input(label: 'Nama Lengkap', controller: namaController),
            const Spacer(),
            _saveButton(context),
          ],
        ),
      ),
    );
  }

  Widget _input({
    required String label,
    required TextEditingController controller,
    bool dropdown = false,
  }) {
    return TextField(
      controller: controller,
      style: GoogleFonts.beVietnamPro(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: dropdown ? const Icon(Icons.keyboard_arrow_down) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF00006F), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
      ),
    );
  }

  Widget _saveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00006F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Rekening berhasil diperbaharui',
                style: GoogleFonts.beVietnamPro(),
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              duration: const Duration(seconds: 2),
            ),
          );

          Future.delayed(const Duration(milliseconds: 1500), () {
            Navigator.pop(context);
          });
        },
        child: Text('Simpan', style: GoogleFonts.beVietnamPro(fontSize: 16)),
      ),
    );
  }
}
