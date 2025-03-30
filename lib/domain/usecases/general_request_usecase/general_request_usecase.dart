import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/general_request_model/general_request_model.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/general_request_repository/general_request_repository.dart';

class CreateGeneralRequestUsecase {
  final GeneralRequestRepository generalRequestRepository;

  CreateGeneralRequestUsecase(this.generalRequestRepository);

  Future<DataState<ResponseModel>> call(GeneralRequestModel model) {
    return generalRequestRepository.createRequestRepository(model);
  }
}
