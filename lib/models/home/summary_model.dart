class Summary {
  final double deposit;
  final double withdraw;

  Summary({required this.deposit, required this.withdraw});

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      deposit: (json['deposit'] as num).toDouble(),
      withdraw: (json['withdraw'] as num).toDouble(),
    );
  }
}
