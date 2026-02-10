import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/home_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static const int _pageSize = 10;
  int _currentPage = 1;

  List<Map<String, dynamic>> _allTransactions = [];

  Future<void> loadHome({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _allTransactions.clear();
    }

    final data = await HomeService.fetchHome();

    _allTransactions = List.from(data['transactions'] ?? []);

    final visible = _allTransactions.take(_currentPage * _pageSize).toList();

    emit(
      HomeLoaded(
        data: data, //
        visibleTransactions: visible,
        hasMore: _allTransactions.length > visible.length,
      ),
    );
  }

  void loadMore() async {
    await Future.delayed(const Duration(milliseconds: 500));

    print('load more called');
    if (state is! HomeLoaded) return;

    final current = state as HomeLoaded;
    if (!current.hasMore) return;

    _currentPage++;

    final nextCount = _currentPage * _pageSize;
    final newList = _allTransactions.take(nextCount).toList();

    print('Data yang tampil: ${newList.length}');

    emit(
      HomeLoaded(
        data: current.data,
        visibleTransactions: newList,
        hasMore: _allTransactions.length > newList.length,
      ),
    );
  }

  Future<void> addTransaction(Map<String, dynamic> trx) async {
    try {
      final home = await HomeService.fetchHome();

      final List transactions = List.from(home['transactions'] ?? []);

      transactions.insert(0, trx);

      double wajib = (home['saldo']?['wajib'] as num?)?.toDouble() ?? 0.0;
      double sukarela = (home['saldo']?['sukarela'] as num?)?.toDouble() ?? 0.0;

      final String trxType = trx['type'];
      final String category = trx['category'];
      final double amount =
          double.tryParse(trx['amount']?.toString() ?? '') ?? 0.0;

      if (category == 'wajib') {
        wajib += trxType == 'withdraw' ? -amount : amount;
      }

      if (category == 'sukarela') {
        sukarela += trxType == 'withdraw' ? -amount : amount;
      }

      final updatedHome = {
        ...home,
        'transactions': transactions,
        'saldo': {
          'wajib': wajib,
          'sukarela': sukarela,
          'total': wajib + sukarela,
        },
      };

      await HomeService.updateHome(updatedHome);
      await loadHome(refresh: true);
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
