import 'dart:io';

import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:dio/dio.dart';

import '../../../domain/repositories/otp_repository/otp_repository.dart';
import '../../sources/otp_service/otp_service.dart';

class ValidateOtpRepositoryImpl implements OtpRepository {
  final OtpService otpService;
  ValidateOtpRepositoryImpl(this.otpService);

  @override
  Future<DataState<ResponseModel>> validateOtpRepository(
      String mobileNumber, int otp) async {
    try {
      final httpResponse = await otpService.validateOtpService(mobileNumber, otp);
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

  @override
  Future<DataState<ResponseModel>> sendOtpRepository(
      String userId, String mobileNumber) async {
    try {
      final httpResponse =
          await otpService.sendOtpService(mobileNumber, userId);

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

   @override
  Future<DataState<ResponseModel>> resendOtpRepository(
       String mobileNumber) async {
    try {
      final httpResponse =
          await otpService.resendOtpService(mobileNumber);

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
