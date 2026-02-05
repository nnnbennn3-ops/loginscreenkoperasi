import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'portofolio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showSaldo = true;
  //int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            const SizedBox(height: 6),
            _saldoCard(),
            _riwayatTitle(),
            _riwayatList(),
          ],
        ),
      ),
      //bottomNavigationBar: _bottomNav(),
    );
  }

  // ================= HEADER =================
  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          const CircleAvatar(radius: 22, backgroundColor: Colors.grey),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, User!',
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '50739',
                style: GoogleFonts.manrope(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= SALDO CARD =================
  Widget _saldoCard() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF2D1DA8), Color(0xFF4F46E5), Color(0xFF6D6AF7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.25),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Saldo',
              style: GoogleFonts.manrope(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Text(
                  showSaldo ? 'Rp 12.500.000' : '•••••••••',
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showSaldo = !showSaldo;
                    });
                  },
                  child: Icon(
                    showSaldo ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white70,
                    size: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _saldoItem('Simpanan Wajib', 'Rp 10.000.000'),
                _saldoItem('Simpanan Sukarela', 'Rp 2.500.000'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _saldoItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          showSaldo ? value : '••••••',
          style: GoogleFonts.manrope(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  // ================= RIWAYAT =================
  Widget _riwayatTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Riwayat Transaksi',
            style: GoogleFonts.beVietnamPro(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Bulannya
              Text(
                'Bulan ini',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Outgoing: Rp 175.000',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Incoming: Rp 600.000',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _riwayatList() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _trxItem(
            icon: Icons.account_balance_wallet,
            title: 'Penarikan Dana',
            date: '02 Jun 2025, 09.15',
            amount: '-Rp 150.000',
            isMinus: true,
          ),
          const Divider(color: Colors.grey),
          _trxItem(
            icon: Icons.savings,
            title: 'Setoran Dana',
            date: '02 Jun 2025, 09.15',
            amount: '+Rp 200.000',
            isMinus: false,
          ),
          const Divider(color: Colors.grey),
          _trxItem(
            icon: Icons.store,
            title: 'Indomaret Kopkar',
            date: '02 Jun 2025, 09.15',
            amount: '-Rp 75.000',
            isMinus: true,
          ),
          const Divider(color: Colors.grey),
          _trxItem(
            icon: Icons.attach_money,
            title: 'SHU',
            date: '02 Jun 2025, 09.15',
            amount: '+Rp 500.000',
            isMinus: false,
          ),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }

  Widget _trxItem({
    required IconData icon,
    required String title,
    required String date,
    required String amount,
    required bool isMinus,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blue.shade50,
            child: Icon(icon, color: Colors.blue, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
                ),
                Text(
                  date,
                  style: GoogleFonts.manrope(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w600,
              color: isMinus ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  // ================= BOTTOM NAV =================
  // Widget _bottomNav() {
  //   return BottomNavigationBar(
  //     currentIndex: _currentIndex,
  //     selectedItemColor: const Color(0xFF0B1E8A),
  //     unselectedItemColor: Colors.grey,

  //     onTap: (index) {
  //       if (index == _currentIndex) return;

  //       setState(() => _currentIndex = index);

  //       if (index == 1) {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (_) => const PortofolioScreen()),
  //         );
  //       }
  //     },
  //     items: const [
  //       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.pie_chart),
  //         label: 'Portofolio',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.description),
  //         label: 'Formulir',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.settings),
  //         label: 'Pengaturan',
  //       ),
  //     ],
  //   );
  // }
}
