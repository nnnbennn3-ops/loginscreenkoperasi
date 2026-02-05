import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormulirScreen extends StatelessWidget {
  const FormulirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Formulir',
          style: GoogleFonts.beVietnamPro(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        children: const [
          _FormItem(
            title: 'Form Pengajuan Member Baru',
            subtitle: '5 May 2025',
          ),
          _FormItem(
            title: 'Form Pinjaman',
            subtitle: 'Last updated at 3 May 2025',
          ),
          _FormItem(
            title: 'Form top up pinjaman',
            subtitle: 'Last updated at 2 May 2025',
          ),
          _FormItem(
            title: 'Form Pengambilan Pinjaman Sukarela',
            subtitle: 'Last updated at 2 May 2025',
          ),
        ],
      ),
    );
  }
}

class _FormItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _FormItem({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // INI BUAT PDF / APInya
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.picture_as_pdf,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
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
