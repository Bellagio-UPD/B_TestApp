import 'package:bellagio_mobile_user/data/models/forgot_password_model/forgot_password_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';
import '../../models/response_model/response_model.dart';

part 'forgot_password_service.g.dart';

@RestApi(baseUrl: urlUsrMgt)
abstract class ForgotPasswordService {
  factory ForgotPasswordService(Dio dio) = _ForgotPasswordService;

  @POST('/Mobile/reset/password')
  Future<HttpResponse<ResponseModel>> resetPassword(
    @Body() ForgotPasswordModel forgotPasswordModel
  );
}