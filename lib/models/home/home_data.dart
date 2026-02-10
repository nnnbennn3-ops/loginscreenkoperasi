import 'saldo_model.dart';
import 'summary_model.dart';
import 'transaction_model.dart';

class HomeData {
  final Saldo saldo;
  final Summary summary;
  final List<TransactionModel> transactions;

  HomeData({
    required this.saldo,
    required this.summary,
    required this.transactions,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      saldo: Saldo.fromJson(json['saldo']),
      summary: Summary.fromJson(json['summary']),
      transactions:
          (json['transactions'] as List)
              .map((e) => TransactionModel.fromJson(e))
              .toList(),
    );
  }
}
