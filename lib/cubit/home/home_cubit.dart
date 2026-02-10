import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/home_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> loadHome() async {
    emit(HomeLoading());
    try {
      final data = await HomeService.fetchHome();
      emit(HomeLoaded(data));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> addTransaction(Map<String, dynamic> trx) async {
    if (state is! HomeLoaded) return;

    final current = (state as HomeLoaded).data;

    final amount = (trx['amount'] as num).toDouble();
    final type = trx['type'];
    final category = trx['category'];

    final saldo = Map<String, dynamic>.from(current['saldo']);
    final summary = Map<String, dynamic>.from(current['summary']);
    final transactions = List<Map<String, dynamic>>.from(
      current['transactions'],
    );

    if (category != 'wajib' && category != 'sukarela') {
      emit(HomeError('Kategori tidak valid'));
      emit(HomeLoaded(current));
      return;
    }

    if (type == 'withdraw' && category == 'wajib') {
      emit(HomeError('Simpanan wajib tidak bisa ditarik'));
      emit(HomeLoaded(current));
      return;
    }

    if (type == 'withdraw' && saldo[category] < amount) {
      emit(HomeError('Saldo tidak mencukupi'));
      emit(HomeLoaded(current));
      return;
    }

    // ----- Buat update saldonya -----
    if (type == 'deposit') {
      saldo[category] += amount;
      summary['deposit'] += amount;
    } else {
      saldo[category] -= amount;
      summary['withdraw'] += amount;
    }

    saldo['total'] = saldo['wajib'] + saldo['sukarela'];

    // ----- Add Transaksiong -----
    transactions.add(trx);
    transactions.sort((a, b) {
      final da = DateTime.parse(a['date']);
      final db = DateTime.parse(b['date']);
      return db.compareTo(da); //ini biar transaksi paling baru ditaro di atas
    });

    final updated = {
      ...current,
      'saldo': saldo,
      'summary': summary,
      'transactions': transactions,
    };

    emit(HomeLoaded(updated));

    try {
      await HomeService.updateHome(updated);
    } catch (e) {
      emit(HomeError('Gagal sinkronisasi ke server'));
      emit(HomeLoaded(current));
    }
  }
}
