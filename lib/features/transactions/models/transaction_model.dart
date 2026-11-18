class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final String category;
  final String type;
  final DateTime date;
  final String? walletId;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.type,
    required this.date,
    this.walletId,
  });
}