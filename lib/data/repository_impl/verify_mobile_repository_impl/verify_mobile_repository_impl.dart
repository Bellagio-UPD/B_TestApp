import 'dart:io';

import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/sources/verify_mobile_number_service/verify_mobile_number_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/verify_mobile_number_repository/verify_mobile_number_repository.dart';
import 'package:dio/dio.dart';

import '../../models/response_model/response_model.dart';

class VerifyMobileRepositoryImpl implements VerifyMobileNumberRepository {
  final VerifyMobileNumberService _verifyMobileNumberService;
  VerifyMobileRepositoryImpl(this._verifyMobileNumberService);

  @override
  Future<DataState<ResponseModel>> verifyMobileNumber (String mobileNumber) async {
    try {
      final httpResponse =
          await _verifyMobileNumberService.verifyMobileNumber(mobileNumber: mobileNumber);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            type: DioExceptionType.badResponse,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
            error: httpResponse.response));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
