import 'dart:io';

import 'package:bellagio_mobile_user/data/models/general_request_model/general_request_model.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/data/sources/general_request_service/general_request_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/general_request_repository/general_request_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/storage/data_state.dart';

class GeneralRequestRepositoryImpl implements GeneralRequestRepository {
  final GeneralRequestService _generalRequestService;
  GeneralRequestRepositoryImpl(this._generalRequestService);

  @override
  Future<DataState<ResponseModel>> createRequestRepository(
      GeneralRequestModel model) async {
    try {
      final httpResponse =
          await _generalRequestService.createGeneralRequest(model);
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
