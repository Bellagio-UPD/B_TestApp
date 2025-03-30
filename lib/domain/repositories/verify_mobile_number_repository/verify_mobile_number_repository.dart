import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';

import '../../../core/storage/data_state.dart';

abstract class VerifyMobileNumberRepository {
  Future<DataState<ResponseModel>> verifyMobileNumber(String mobileNumber);
}
