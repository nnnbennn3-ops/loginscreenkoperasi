import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'rekening_screen.dart';
import 'changepassword_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Personal Information'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          _profileHeader(),
          const Divider(height: 1),
          _menuItem(
            icon: Icons.account_balance,
            title: 'Rekening Bank',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RekeningBankScreen()),
              );
            },
          ),
          _menuItem(
            icon: Icons.lock_outline,
            title: 'Ganti Password',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
              );
            },
          ),
          const Divider(color: Colors.grey),
          _menuItem(
            icon: Icons.logout,
            title: 'Logout',
            danget: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // ----- Ini Kode Headernya -----
  Widget _profileHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 28, //ngatur gede kecil fotonya
                backgroundColor: Colors.grey.shade300,
                //backgroundImage: const AssetImage
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0B1E8A),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '50739',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ----- Ini Kode Menu Itemnya -----
  Widget _menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool danget = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(icon, color: danget ? Colors.red : Colors.grey),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: danget ? Colors.red : Colors.black,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
          ],
        ),
      ),
    );
  }
}
