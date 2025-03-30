import 'package:bellagio_mobile_user/data/models/deposits_model/deposits_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/deposits_repository/deposits_repository.dart';

import '../../../core/storage/data_state.dart';
import '../usecase/usecase.dart';

class GetDepositsUsecase implements UseCase<DataState<List<DepositModel>>, void> {
  final DepositsRepository _depositsRepository;

  GetDepositsUsecase(this._depositsRepository);
  @override
  Future<DataState<List<DepositModel>>> call({void params}) {
    return _depositsRepository.getDeposits();
  }
}