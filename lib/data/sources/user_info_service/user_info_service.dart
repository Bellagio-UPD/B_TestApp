import 'package:bellagio_mobile_user/data/models/user_info_model/user_info_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/constants/urls.dart';

part 'user_info_service.g.dart';

@RestApi(baseUrl: urlCstmReqMgt)
abstract class UserInfoService {
  factory UserInfoService(Dio dio) = _UserInfoService;

  @GET('/find/customer')
  Future<HttpResponse<UserInfoModel>> getUserInfo(
      {@Query("customerId") String? userId});
}
