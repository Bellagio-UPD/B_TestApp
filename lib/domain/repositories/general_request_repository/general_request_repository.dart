import 'package:bellagio_mobile_user/data/models/general_request_model/general_request_model.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';

import '../../../core/storage/data_state.dart';

abstract class GeneralRequestRepository {
  Future<DataState<ResponseModel>> createRequestRepository(
      GeneralRequestModel generalRequestModel);
}
