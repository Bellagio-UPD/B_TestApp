import 'package:bellagio_mobile_user/data/models/forgot_password_model/forgot_password_model.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';

import '../../../core/storage/data_state.dart';

abstract class ForgotPasswordRepository {
  Future<DataState<ResponseModel>> forgotPasswordRepository(
      ForgotPasswordModel forgotPasswordModel);
}
