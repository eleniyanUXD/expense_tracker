import 'package:expense_tracker/database/daos/wallet_dao.dart';
import 'package:expense_tracker/features/wallet/models/wallet_model.dart';

class WalletRepository {
  final WalletDao _walletDao;

  WalletRepository(this._walletDao);

  List<WalletModel> getWallets() {
    return _walletDao.getWallets();
  }

  Future<void> addWallet(WalletModel wallet) async {
    await _walletDao.addWallet(wallet);
  }

  Future<void> updateWallet(WalletModel wallet) async {
    await _walletDao.updateWallet(wallet);
  }

  Future<void> deleteWallet(String id) async {
    await _walletDao.deleteWallet(id);
  }
}
