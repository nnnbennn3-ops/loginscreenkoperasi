class TransactionModel {
  final String type;
  final String title;
  final String date;
  final double amount;

  TransactionModel({
    required this.type,
    required this.title,
    required this.date,
    required this.amount,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      type: json['type'] as String,
      title: json['title'] as String,
      date: json['date'] as String,
      amount: (json['amount'] as num).toDouble(),
    );
  }
}
