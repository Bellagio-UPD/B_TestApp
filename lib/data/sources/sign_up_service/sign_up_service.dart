import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';
import '../../models/sign_up_model/sign_up_model.dart';

part 'sign_up_service.g.dart';

@RestApi(baseUrl: baseURL)
abstract class SignUpService {
  factory SignUpService(Dio dio) = _SignUpService;

  @POST('/user-mgt-app1659/firebase/create/customer')
  Future<HttpResponse<ResponseModel>> createUser(
    @Body() SignUpModel signUpModel
  );
}
