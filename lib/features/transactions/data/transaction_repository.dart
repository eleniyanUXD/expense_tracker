import '../models/transaction_model.dart';
import '../../../../database/daos/transaction_dao.dart';

class TransactionRepository {
  final TransactionDao _transactionDao;

  TransactionRepository(this._transactionDao);

  // Get all transactions
  List<TransactionModel> getTransactions() {
    return _transactionDao.getTransactions();
  }

  // Add a transaction
  Future<void> addTransaction(TransactionModel transaction) async {
    await _transactionDao.addTransaction(transaction);
  }

  // Update a transaction
  Future<void> updateTransaction(TransactionModel transaction) async {
    await _transactionDao.updateTransaction(transaction);
  }

  // Delete a transaction
  Future<void> deleteTransaction(String id) async {
    await _transactionDao.deleteTransaction(id);
  }
}