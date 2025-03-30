import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/deposits_model/deposits_model.dart';

abstract class DepositsRepository {
  Future<DataState<List<DepositModel>>> getDeposits();
}
