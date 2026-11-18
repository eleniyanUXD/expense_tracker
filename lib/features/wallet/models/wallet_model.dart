class WalletModel {
  final String id;
  final String name;
  final double balance;
  final String currency;
  final DateTime createdAt;

  const WalletModel({
    required this.id,
    required this.name,
    required this.balance,
    required this.currency,
    required this.createdAt,
  });
}
