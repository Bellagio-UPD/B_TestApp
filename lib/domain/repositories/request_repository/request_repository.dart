import 'package:bellagio_mobile_user/data/models/request_model/request_model.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';

import '../../../core/storage/data_state.dart';

abstract class RequestRepository {
  Future<DataState<ResponseModel>> sendUserRequest(RequestModel requestModel);
}
