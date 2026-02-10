abstract class LoanState {}

class LoanInitial extends LoanState {}

class LoanLoading extends LoanState {}

class LoanLoaded extends LoanState {
  final Map<String, dynamic> data;
  LoanLoaded(this.data);
}

class LoanError extends LoanState {
  final String message;
  LoanError(this.message);
}
