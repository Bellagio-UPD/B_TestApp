import 'package:bellagio_mobile_user/data/models/withdrawals_model/withdrawal_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/withdrawal_repository/withdrawal_repository.dart';

import '../../../core/storage/data_state.dart';
import '../usecase/usecase.dart';

class GetWithdrawalUsecase implements UseCase<DataState<List<WithdrawalModel>>, void> {
  final WithdrawalRepository _withdrawalRepository;

  GetWithdrawalUsecase(this._withdrawalRepository);
  @override
  Future<DataState<List<WithdrawalModel>>> call({void params}) {
    return _withdrawalRepository.getWithdrawals();
  }
}