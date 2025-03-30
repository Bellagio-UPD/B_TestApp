import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/withdrawals_model/withdrawal_model.dart';

abstract class WithdrawalRepository {
  Future<DataState<List<WithdrawalModel>>> getWithdrawals();
}
