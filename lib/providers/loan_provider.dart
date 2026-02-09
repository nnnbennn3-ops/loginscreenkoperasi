import 'package:flutter/material.dart';
import '../services/loan_service.dart';

class LoanProvider extends ChangeNotifier {
  Map<String, dynamic>? _loanData;
  bool _isLoading = true;

  Map<String, dynamic>? get loanData => _loanData;
  bool get isLoading => _isLoading;

  LoanProvider() {
    _load();
  }

  Future<void> _load() async {
    _loanData = await fetchLoanDetail();
    _isLoading = false;
    notifyListeners();
  }

  // Simulasi bayar cicilan
  Future<void> payInstallment(int installmentNo) async {
    final installments = List<Map<String, dynamic>>.from(
      _loanData!['installments'],
    );

    final idx = installments.indexWhere(
      (e) => e['installment_no'] == installmentNo,
    );

    if (idx == -1) return;
    if (installments[idx]['status'] == 'paid') return;

    installments[idx]['status'] = 'paid';

    final summary = _loanData!['summary'];
    summary['paid_installment'] += 1;
    summary['principal_paid'] += installments[idx]['idx']['amount'];
    summary['remaining_loan'] =
        summary['total_loan'] - summary['principal_paid'];

    _loanData!['installments'] = installments;

    notifyListeners();
    await updateLoanDetail(_loanData!);
  }
}
