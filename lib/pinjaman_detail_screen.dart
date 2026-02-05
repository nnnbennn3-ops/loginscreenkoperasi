import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'simulasi_pinjaman_page.dart';

class PinjamanDetailScreen extends StatelessWidget {
  const PinjamanDetailScreen({super.key});

  String rupiah(double v) {
    return 'Rp ${v.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';
  } //Regex buat tulisan rupiah

  // Widget halfCircleProgress({
  //   required double progress, // 0.0 - 1.0
  //   required double size,
  //   required Color color,
  //   required Color backgroundColor,
  // }) {
  //   return SizedBox(
  //     width: size,
  //     height: size / 2,
  //     child: ClipRect(
  //       child: Align(
  //         alignment: Alignment.topCenter,
  //         heightFactor: 0.5,
  //         child: Transform.rotate(
  //           angle: 3.1415926535, // 180 derajat
  //           child: SizedBox(
  //             width: size,
  //             height: size,
  //             child: CircularProgressIndicator(
  //               value: progress,
  //               strokeWidth: 12,
  //               backgroundColor: backgroundColor,
  //               valueColor: AlwaysStoppedAnimation<Color>(color),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      appBar: AppBar(
        title: Text(
          'Pinjaman',
          style: GoogleFonts.beVietnamPro(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          _ringkasan(context),
          const SizedBox(height: 12),
          _info(),
          const SizedBox(height: 12),
          Expanded(child: _history()),
        ],
      ),
    );
  }

  // ----- Widget Ringkasan -----
  Widget _ringkasan(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF8B0000),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                'assets/pinjam.jpeg',
                width: 32,
                height: 32,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: CircularProgressIndicator(
                    value: 0.5, // 50%
                    strokeWidth: 12,
                    backgroundColor: Colors.red.shade100,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF8B0000),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sisa Pinjaman',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      rupiah(3000000),
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF8B0000),
                      ),
                    ),
                    Text(
                      'Dari ${rupiah(6000000)}',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      'Lunasi Semua',
                      style: GoogleFonts.beVietnamPro(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B0000),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SimulasiPinjamanPage(),
                        ),
                      );
                    },
                    child: const Text('Simulasi'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ----- Widget Info -----
  Widget _info() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _infoRow('Sudah membayar', '6 dari total 12 cicilan'),
          _infoRow('Pembayaran Selanjutnya', '10 Juni 2025'),
          _infoRow('Pokok Hutang Dibayar', rupiah(3000000)),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.beVietnamPro(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.beVietnamPro(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ----- Widget History -----
  Widget _history() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 12,
        itemBuilder: (_, i) {
          final lunas = i < 6;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cicilan ${i + 1} dari 12',
                        style: GoogleFonts.beVietnamPro(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '25 May 2025, 09.15',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        rupiah(500000),
                        style: GoogleFonts.beVietnamPro(
                          color: lunas ? Colors.black : Colors.grey,
                        ),
                      ),
                      Text(
                        lunas ? 'Lunas' : 'Belum ada tagihan',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 12,
                          color: lunas ? Colors.green : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
