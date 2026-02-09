import 'package:flutter/material.dart';
// import 'package:koperasi_login_full/providers/loan_provider.dart';
import 'login_screen.dart';
// import 'package:provider/provider.dart';
// import 'providers/home_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Koperasi Indomobil',
      theme: ThemeData(
        useMaterial3: false,
        primaryColor: const Color(0xFF0B1E8A),
      ),
      home: const LoginScreen(),
    );
  }
}
