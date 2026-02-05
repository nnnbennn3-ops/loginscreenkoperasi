import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpananDetailScreen extends StatelessWidget {
  final String title;
  final double saldo;
  final Color primaryColor;
  final IconData icon;

  const SimpananDetailScreen({
    super.key,
    required this.title,
    required this.saldo,
    required this.primaryColor,
    required this.icon,
  });

  String rupiah(double v) {
    return 'Rp ${v.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';
  } //Regex buat tulisan rupiah

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        foregroundColor: Colors.black,
        title: Text(
          title,
          style: GoogleFonts.beVietnamPro(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          _saldoCard(),
          const SizedBox(height: 8),
          Expanded(child: _history()),
        ],
      ),
    );
  }

  // ===== SALDO CARD =====
  Widget _saldoCard() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 254, 254, 254),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Color.fromARGB(31, 125, 45, 45), blurRadius: 10),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              rupiah(saldo),
              style: GoogleFonts.beVietnamPro(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== HISTORY =====
  Widget _history() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== TITLE =====
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Text(
              'History',
              style: GoogleFonts.beVietnamPro(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // ===== SUB HEADER =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _historyHeader(),
          ),

          const SizedBox(height: 8),
          Divider(color: Colors.grey.shade300, height: 1),

          // ===== LIST =====
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                _HistoryItem(
                  title: 'Penarikan Dana',
                  date: '02 Jun 2025, 09.15',
                  amount: '-Rp 150.000',
                  minus: true,
                  icon: Icons.account_balance_wallet,
                ),
                Divider(),
                _HistoryItem(
                  title: 'Setoran Dana',
                  date: '25 May 2025, 09.15',
                  amount: '+Rp 200.000',
                  icon: Icons.savings,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _historyHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Jun 2025', style: GoogleFonts.inter(color: Colors.grey)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Outgoing: Rp 175.000',
              style: GoogleFonts.beVietnamPro(fontSize: 12),
            ),
            Text(
              'Incoming: Rp 600.000',
              style: GoogleFonts.beVietnamPro(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final bool minus;
  final IconData icon;

  const _HistoryItem({
    required this.title,
    required this.date,
    required this.amount,
    required this.icon,
    this.minus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blue.shade50,
            child: Icon(icon, size: 18, color: Colors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w600),
                ),
                Text(
                  date,
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.beVietnamPro(
              color: minus ? Colors.red : Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
