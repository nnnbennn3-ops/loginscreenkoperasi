import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0xFF0B1E8A),
      ),
      body: const Center(child: Text('Selamat datang di Aplikasi Koperasi')),
    );
  }
}
