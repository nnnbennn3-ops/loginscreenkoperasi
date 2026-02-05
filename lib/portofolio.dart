import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'simpanan_detail_screen.dart';
import 'pinjaman_detail_screen.dart';

class PortofolioScreen extends StatelessWidget {
  const PortofolioScreen({super.key});

  //Data Boongan, nanti kan dari backend/db
  final double simpananWajib = 5000000;
  final double simpananSukarela = 2500000;
  final double sisaPinjaman = 3000000;

  double get totalSaldo => simpananWajib + simpananSukarela;

  String rupiah(double v) {
    return 'Rp ${v.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';
  } //Regular Expression buat format rupiah

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Portofolio',
          style: GoogleFonts.beVietnamPro(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _totalSaldo(),
            const SizedBox(height: 16),
            _simpananWajibCard(context),
            const SizedBox(height: 12),
            _simpananSukarelaCard(context),
            const SizedBox(height: 12),
            _pinjamanCard(context),
          ],
        ),
      ),
    );
  }

  // ----- Widget Total Saldo -----
  Widget _totalSaldo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total Saldo',
          style: GoogleFonts.beVietnamPro(
            fontSize: 20,
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          rupiah(totalSaldo),
          style: GoogleFonts.beVietnamPro(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  // ----- Widget Simpanan Wajib -----
  Widget _simpananWajibCard(BuildContext context) {
    return _baseCard(
      context,
      color: Colors.white,
      border: true,
      title: 'Simpanan Wajib',
      amount: rupiah(simpananWajib),
      iconBg: const Color(0xFF0B1E8A),
      icon: Icons.receipt_long,
      darkText: true,
    );
  }

  // ----- Widget Simpanan Sukarela -----
  Widget _simpananSukarelaCard(BuildContext context) {
    return _baseCard(
      context,
      color: const Color(0xFF0B1E8A),
      title: 'Simpanan Sukarela',
      amount: rupiah(simpananSukarela),
      iconBg: Colors.white,
      icon: Icons.account_balance_wallet,
    );
  }

  // ----- Widget Pinjaman -----
  Widget _pinjamanCard(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PinjamanDetailScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xff8b0000),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pinjaman',
                    style: GoogleFonts.beVietnamPro(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Sisa Pinjaman',
                    style: GoogleFonts.beVietnamPro(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    rupiah(sisaPinjaman),
                    style: GoogleFonts.beVietnamPro(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tanggal Cicilan\n15 Jun 2025',
                    style: GoogleFonts.beVietnamPro(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Lihat Detail →',
                    style: GoogleFonts.beVietnamPro(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 64,
                  height: 64,
                  child: CircularProgressIndicator(
                    value: 0.5,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                    strokeWidth: 6,
                  ),
                ),
                Text(
                  '50%',
                  style: GoogleFonts.beVietnamPro(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ----- Base Card -----
  Widget _baseCard(
    BuildContext context, {
    required Color color,
    required String title,
    required String amount,
    required Color iconBg,
    required IconData icon,
    bool border = false,
    bool darkText = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border:
            border ? Border.all(color: Colors.grey.shade300, width: 1) : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: darkText ? Colors.black : Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  amount,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkText ? Colors.black : Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => SimpananDetailScreen(
                              title: title,
                              saldo:
                                  title == 'Simpanan Wajib'
                                      ? simpananWajib
                                      : simpananSukarela,
                              primaryColor:
                                  title == 'Simpanan Wajib'
                                      ? const Color(0xFF0B1E8A)
                                      : const Color(0xFF1E40AF),
                              icon:
                                  title == 'Simpanan Wajib'
                                      ? Icons.receipt_long
                                      : Icons.account_balance_wallet,
                            ),
                      ),
                    );
                  },
                  child: Text(
                    'Lihat Detail →',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 15,
                      color: darkText ? Colors.grey.shade600 : Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: darkText ? Colors.white : Colors.blue.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
