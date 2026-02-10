import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/loan_service.dart';
import 'loan_state.dart';

class LoanCubit extends Cubit<LoanState> {
  LoanCubit() : super(LoanInitial());

  static const int _pageSize = 6;
  int _currentPage = 1;

  List<Map<String, dynamic>> _allInstallments = [];
  Map<String, dynamic>? _loanData;

  Future<void> loadLoan({bool refresh = false}) async {
    try {
      if (refresh) {
        _currentPage = 1;
        _allInstallments.clear();
      }

      emit(LoanLoading());

      final loan = await fetchLoanDetail();

      _loanData = loan;
      _allInstallments = List<Map<String, dynamic>>.from(
        loan['installments'] ?? [],
      );

      final visible = _allInstallments.take(_currentPage * _pageSize).toList();

      emit(
        LoanLoaded(
          data: loan,
          installments: visible,
          hasMore: _allInstallments.length > visible.length,
        ),
      );
    } catch (e) {
      emit(LoanError(e.toString()));
    }
  }

  void loadMore() {
    print('load more called');
    if (state is! LoanLoaded) return;
    final current = state as LoanLoaded;
    if (!current.hasMore) return;

    _currentPage++;

    final visible = _allInstallments.take(_currentPage * _pageSize).toList();

    emit(
      LoanLoaded(
        data: _loanData!,
        installments: visible,
        hasMore: _allInstallments.length > visible.length,
      ),
    );
  }
}
