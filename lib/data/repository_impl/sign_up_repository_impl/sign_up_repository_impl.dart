import 'dart:io';

import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/data/models/sign_up_model/sign_up_model.dart';
import 'package:bellagio_mobile_user/data/sources/sign_up_service/sign_up_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/sign_up_repository/sign_up_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/storage/data_state.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpService _signUpService;
  SignUpRepositoryImpl(this._signUpService);

  @override
  Future<DataState<ResponseModel>> signUpUser(SignUpModel signUpModel) async {
    try {
      final httpResponse = await _signUpService.createUser(signUpModel);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> responseData = httpResponse.response.data;
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
