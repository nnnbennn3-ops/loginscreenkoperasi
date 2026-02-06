import 'package:flutter/material.dart';
import '../services/home_service.dart';

class HomeProvider extends ChangeNotifier {
  Map<String, dynamic>? _homeData;
  bool _isLoading = true;

  Map<String, dynamic>? get homeData => _homeData;
  bool get isLoading => _isLoading;

  HomeProvider() {
    _loadOnce();
  }

  Future<void> _loadOnce() async {
    _homeData = await fetchHomeData();
    _isLoading = false;
    notifyListeners();
  }

  Future<String?> addTransaction(Map<String, dynamic> trx) async {
    final amount = (trx['amount'] as num).toDouble();
    final type = trx['type'];
    final category = trx['category'];

    final saldo = _homeData!['saldo'];

    //ATURAN
    if (category != 'wajib' && category != 'sukarela') {
      return 'Kategori simpanan tidak valid';
    }
    if (type == 'withdraw' && category == 'wajib') {
      return 'Simpanan wajib tidak bisa ditarik';
    }

    if (type == 'withdraw' && category == 'sukarela') {
      if (saldo['sukarela'] < amount) {
        return 'Saldo sukarela tidak mencukupi';
      }
    }

    // UPDATE SALDO
    if (type == 'deposit') {
      saldo[category] += amount;
      _homeData!['summary']['deposit'] += amount;
    } else {
      saldo[category] -= amount;
      _homeData!['summary']['withdraw'] += amount;
    }

    //TOTAL SELALU HASIL HITUNG
    saldo['total'] = saldo['wajib'] + saldo['sukarela'];

    // INSERT TRANSAKSI
    final List<Map<String, dynamic>> transactions =
        List<Map<String, dynamic>>.from(_homeData!['transactions']);

    transactions.insert(0, trx);
    _homeData!['transactions'] = transactions;

    notifyListeners(); // optimistic UI

    //SYNC KE MOCKAPI
    try {
      await updateHomeData(_homeData!);
    } catch (_) {
      return 'Gagal Sinkron ke Server';
    }
    return null;
  }
}
