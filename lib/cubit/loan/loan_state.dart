abstract class LoanState {}

class LoanInitial extends LoanState {}

class LoanLoading extends LoanState {}

class LoanLoaded extends LoanState {
  final Map<String, dynamic> data;
  final List<Map<String, dynamic>> installments;
  final bool hasMore;

  LoanLoaded({
    required this.data,
    required this.installments,
    required this.hasMore,
  });
}

class LoanError extends LoanState {
  final String message;
  LoanError(this.message);
}
