import 'dart:io';

import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/fcm_token/fcm_token_model.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:dio/dio.dart';
import '../../../domain/repositories/fcm_token_register_repository/fcm_token_register_repository.dart';
import '../../sources/fcm_token_register_repository_service/fcm_token_register_repository_service.dart';

class FCMRegisterRequestRepositoryImpl implements FCMRegisterRequestRepository {

  final FCMRegisterRequestService fCMRegisterRequestService;
  FCMRegisterRequestRepositoryImpl(this.fCMRegisterRequestService);

  @override
  Future<DataState<ResponseModel>> fcmTokenRegistry(FCMTokenRegisterModel fcmTokenRegisterModel) async {
 try {
      final httpResponse = await fCMRegisterRequestService.registerFCMToken(fcmTokenRegisterModel);
      if (httpResponse.response.statusCode == HttpStatus.ok || httpResponse.response.statusCode == HttpStatus.accepted)  {
        return DataSuccess(httpResponse.data);
      }
      else {
        return DataFailed(
          DioException(
              type: DioExceptionType.badResponse,
              response: httpResponse.response,
              requestOptions: RequestOptions(path: ''),
              error: httpResponse.toString()),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }

  }
}
