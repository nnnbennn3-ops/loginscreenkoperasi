abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Map<String, dynamic> data;
  final List<Map<String, dynamic>> visibleTransactions;
  final bool hasMore;

  HomeLoaded({
    required this.data,
    required this.visibleTransactions,
    required this.hasMore,
  });
}

class HomeError extends HomeState {
  final String message;
  final Map<String, dynamic>? data;

  HomeError(this.message, [this.data]);
}
