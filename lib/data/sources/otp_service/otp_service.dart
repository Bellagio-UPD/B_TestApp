import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';
import '../../models/response_model/response_model.dart';

part 'otp_service.g.dart';

@RestApi(baseUrl: baseURL)
abstract class OtpService {
  factory OtpService(Dio dio) = _OtpService;

  @POST('/user-mgt-app1659/validate/otp')
  Future<HttpResponse<ResponseModel>> validateOtpService(
      @Query("mobileNumber") String mobileNumber, @Query("otp") int otp);

  @POST('/user-mgt-app1659/send/otp')
  Future<HttpResponse<ResponseModel>> sendOtpService(
      @Query("mobileNumber") String mobileNumber,
      @Query("userId") String userId);

  @POST('/user-mgt-app1659/mobile/resendotp')
  Future<HttpResponse<ResponseModel>> resendOtpService(
    @Query("mobileNumber") String mobileNumber,
  );
}
