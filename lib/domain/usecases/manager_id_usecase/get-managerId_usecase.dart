import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/manager_id_repository/manager_id_repository.dart';
import 'package:bellagio_mobile_user/domain/usecases/usecase/usecase.dart';

import '../../../core/storage/data_state.dart';

class GetManagerIdUsecase
    implements UseCase<DataState<ResponseModel>, String> {
  final ManagerIdRepository _managerIdRepository;
  GetManagerIdUsecase(this._managerIdRepository);
  @override
  Future<DataState<ResponseModel>> call({void params}) {
    return _managerIdRepository.getManagerIdRepository();
  }
}