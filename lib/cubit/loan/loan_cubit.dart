import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/loan_service.dart';
import 'loan_state.dart';

class LoanCubit extends Cubit<LoanState> {
  LoanCubit() : super(LoanInitial());

  Future<void> loadLoan() async {
    emit(LoanLoading());
    try {
      final data = await fetchLoanDetail();
      emit(LoanLoaded(data));
    } catch (e) {
      emit(LoanError(e.toString()));
    }
  }
}
