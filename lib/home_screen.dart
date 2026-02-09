import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import 'add_transaction_screen.dart';

//import 'portofolio.dart';

// final Map<String, dynamic> homeJson = {
//   "saldo": {"total": 12500000, "wajib": 10000000, "sukarela": 2500000},
//   "summary": {"withdraw": 175000, "deposit": 600000},
//   "transactions": [
//     {
//       "type": "withdraw",
//       "title": "Penarikan Dana",
//       "date": "02 Jun 2025, 09.15",
//       "amount": 150000,
//     },
//     {
//       "type": "deposit",
//       "title": "Setoran Dana",
//       "date": "02 Jun 2025, 09.15",
//       "amount": 200000,
//     },
//     {
//       "type": "withdraw",
//       "title": "Indomaret Kopkar",
//       "date": "02 Jun 2025, 09.15",
//       "amount": 75000,
//     },
//     {
//       "type": "deposit",
//       "title": "SHU",
//       "date": "02 Jun 2025, 09.15",
//       "amount": 500000,
//     },
//   ],
// };

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showSaldo = true;

  String rupiah(double v) {
    return 'Rp ${v.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';
  } //Regular Expression buat format rupiah
  //int _currentIndex = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     context.read<HomeProvider>().loadHome();
  //   });
  // }

  Map<String, List<Map<String, dynamic>>> groupByMonth(
    List<Map<String, dynamic>> transactions,
  ) {
    final Map<String, List<Map<String, dynamic>>> grouped = {};

    for (final trx in transactions) {
      final date = DateTime.parse(trx['date']);
      final key = '${_monthName(date.month)} ${date.year}';

      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(trx);
    }
    return grouped;
  }

  String _monthName(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<HomeProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final homeJson = provider.homeData!;

            return Column(
              children: [
                _header(),
                const SizedBox(height: 6),
                _saldoCard(homeJson),
                _riwayatTitle(homeJson),
                _riwayatList(homeJson),
              ],
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => ChangeNotifierProvider.value(
                    value: context.read<HomeProvider>(),
                    child: const AddTransactionScreen(),
                  ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
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
  Widget _saldoCard(Map<String, dynamic> homeJson) {
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
                  showSaldo
                      ? rupiah((homeJson['saldo']['total'] as num).toDouble())
                      : '•••••••••',
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
                _saldoItem(
                  'Simpanan Wajib',
                  rupiah((homeJson['saldo']['wajib'] as num).toDouble()),
                ),
                _saldoItem(
                  'Simpanan Sukarela',
                  rupiah((homeJson['saldo']['sukarela'] as num).toDouble()),
                ),
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
  Widget _riwayatTitle(Map<String, dynamic> homeJson) {
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
              Text(
                'Bulan ini',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Withdraw: ${rupiah((homeJson['summary']['withdraw'] as num).toDouble())}',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Deposit: ${rupiah((homeJson['summary']['deposit'] as num).toDouble())}',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
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

  Widget _riwayatList(Map<String, dynamic> homeJson) {
    final List<Map<String, dynamic>> transactions =
        List<Map<String, dynamic>>.from(homeJson['transactions']);

    final grouped = groupByMonth(transactions);

    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children:
            grouped.entries.map((entry) {
              final month = entry.key;
              final items = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //HEADER BUAT BULAN
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      month,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  //TRANSAKSI DI BULAN TERTENTU
                  ...items.map((trx) {
                    final isWithdraw = trx['type'] == 'withdraw';

                    return Column(
                      children: [
                        _trxItem(
                          icon:
                              isWithdraw
                                  ? Icons.account_balance_wallet
                                  : Icons.savings,
                          title: trx['title'],
                          date: trx['date'],
                          amount:
                              '${isWithdraw ? '-' : '+'}${rupiah((trx['amount'] as num).toDouble())}',
                          isMinus: isWithdraw,
                        ),
                        const Divider(),
                      ],
                    );
                  }),
                ],
              );
            }).toList(),
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
