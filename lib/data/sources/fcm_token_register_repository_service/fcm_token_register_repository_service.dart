


import 'dart:io';


import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/constants/urls.dart';
import '../../models/fcm_token/fcm_token_model.dart';
import '../../models/response_model/response_model.dart';

part 'fcm_token_register_repository_service.g.dart';

@RestApi(baseUrl: baseURL)
abstract class FCMRegisterRequestService {
  factory FCMRegisterRequestService(Dio dio) = _FCMRegisterRequestService;

  @POST('/notificationmanagement-app1750/create/fcmtoken')
  Future<HttpResponse<ResponseModel>> registerFCMToken(
      @Body() FCMTokenRegisterModel fcmTokenRegisterModel
      );

}
