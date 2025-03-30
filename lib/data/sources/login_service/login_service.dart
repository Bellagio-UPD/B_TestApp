import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/login_user_model.dart/login_user_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';
import '../../models/response_model/response_model.dart';

part 'login_service.g.dart';

@RestApi(baseUrl: urlUsrMgt)
abstract class LoginService {
  factory LoginService(Dio dio) = _LoginService;

  @POST('/mobile/login')
  Future<HttpResponse<ResponseModel>> loginUser(
      @Body() LoginUserModel loginUserModel);
}
