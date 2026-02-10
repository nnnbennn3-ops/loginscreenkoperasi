import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'simulasi_pinjaman_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/loan/loan_cubit.dart';
import 'cubit/loan/loan_state.dart';

class PinjamanDetailScreen extends StatefulWidget {
  const PinjamanDetailScreen({super.key});

  @override
  State<PinjamanDetailScreen> createState() => _PinjamanDetailScreenState();
}

class _PinjamanDetailScreenState extends State<PinjamanDetailScreen> {
  late final ScrollController _scrollController;

  String rupiah(double v) {
    return 'Rp ${v.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';
  }

  @override
  void initState() {
    super.initState();

    context.read<LoanCubit>().loadLoan();

    _scrollController =
        ScrollController()..addListener(() {
          if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200) {
            context.read<LoanCubit>().loadMore();
          }
        });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
      body: BlocConsumer<LoanCubit, LoanState>(
        listener: (context, state) {
          if (state is LoanError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is LoanLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LoanLoaded) {
            final loanJson = state.data;

            return SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _ringkasan(context, loanJson),
                  const SizedBox(height: 12),
                  _info(loanJson),
                  const SizedBox(height: 12),
                  _history(state, loanJson),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  // ================= RINGKASAN =================
  Widget _ringkasan(BuildContext context, Map<String, dynamic> loanJson) {
    final summary = loanJson['summary'];
    final progress = summary['paid_installment'] / summary['total_installment'];

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
              child: Image.asset('assets/pinjam.jpeg', width: 32, height: 32),
            ),
            const SizedBox(height: 16),

            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor: Colors.red.shade100,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF8B0000),
                    ),
                  ),
                ),
                Column(
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
                      rupiah((summary['remaining_loan'] as num).toDouble()),
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF8B0000),
                      ),
                    ),
                    Text(
                      'Dari ${rupiah((summary['total_loan'] as num).toDouble())}',
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

  // ================= INFO =================
  Widget _info(Map<String, dynamic> loanJson) {
    final summary = loanJson['summary'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _infoRow(
            'Sudah membayar',
            '${summary['paid_installment']} dari total ${summary['total_installment']} cicilan',
          ),
          _infoRow('Pembayaran Selanjutnya', summary['next_payment_date']),
          _infoRow(
            'Pokok Hutang Dibayar',
            rupiah((summary['principal_paid'] as num).toDouble()),
          ),
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

  // ================= HISTORY (PAGINATION) =================
  Widget _history(LoanLoaded state, Map<String, dynamic> loanJson) {
    final installments = state.installments;
    final hasMore = state.hasMore;
    final total = loanJson['summary']['total_installment'];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: installments.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == installments.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final trx = installments[index];
          final lunas = trx['status'] == 'paid';

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cicilan ${trx['installment_no']} dari $total',
                          style: GoogleFonts.beVietnamPro(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          trx['date'],
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
                          rupiah((trx['amount'] as num).toDouble()),
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
            ),
          );
        },
      ),
    );
  }
}
