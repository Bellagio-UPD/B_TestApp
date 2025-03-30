import 'dart:io';

import 'package:bellagio_mobile_user/data/models/forgot_password_model/forgot_password_model.dart';
import 'package:bellagio_mobile_user/data/sources/forgot_password_service/forgot_password_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/forgot_password_repository/forgot_password_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/storage/data_state.dart';
import '../../models/response_model/response_model.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordService _forgotPasswordService;
  ForgotPasswordRepositoryImpl(this._forgotPasswordService);

  @override
  Future<DataState<ResponseModel>> forgotPasswordRepository(
      ForgotPasswordModel forgotPasswordModel) async {
    try {
      final httpResponse =
          await _forgotPasswordService.resetPassword(forgotPasswordModel);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
