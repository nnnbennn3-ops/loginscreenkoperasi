import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'portofolio.dart';
import 'formulir_screen.dart';
import 'settings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home/home_cubit.dart';

// import '../providers/home_provider.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return BlocProvider(
          create: (_) => HomeCubit()..loadHome(),
          child: const HomeScreen(),
        );

      case 1:
        return const PortofolioScreen();

      case 2:
        return const FormulirScreen();

      case 3:
        return const SettingsScreen();

      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: List.generate(4, (i) => _buildPage(i)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: const Color(0xFF0B1E8A),
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Portofolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Formulir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
