import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/request_model/request_model.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/request_repository/request_repository.dart';

class RequestUsecase {
  final RequestRepository requestRepository;

  RequestUsecase(this.requestRepository);

  Future<DataState<ResponseModel>> call(RequestModel requestModel) {
    return requestRepository.sendUserRequest(requestModel);
  }
}
