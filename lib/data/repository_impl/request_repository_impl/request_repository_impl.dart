import 'dart:io';

import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:dio/dio.dart';

import '../../../core/storage/data_state.dart';
import '../../../domain/repositories/request_repository/request_repository.dart';
import '../../models/request_model/request_model.dart';
import '../../sources/request_service/request_service.dart';

class RequestRepositoryImpl implements RequestRepository {
  final RequestService _requestService;
  RequestRepositoryImpl(this._requestService);

  @override
  Future<DataState<ResponseModel>> sendUserRequest(
      RequestModel model) async {
    try {
      final httpResponse =
          await _requestService.createRequest(model);
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
