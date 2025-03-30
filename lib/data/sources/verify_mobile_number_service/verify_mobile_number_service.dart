import 'package:bellagio_mobile_user/core/constants/urls.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'verify_mobile_number_service.g.dart';

@RestApi(baseUrl: urlUsrMgt)
abstract class VerifyMobileNumberService {
  factory VerifyMobileNumberService(Dio dio) = _VerifyMobileNumberService;

  @GET('/Mobile/VerifyNo')
  Future<HttpResponse<ResponseModel>> verifyMobileNumber({
    @Query("mobileNumber") String? mobileNumber
  });
}
