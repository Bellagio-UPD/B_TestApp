import 'dart:io';

import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/sources/user_info_service/manager_id_service.dart';
import 'package:bellagio_mobile_user/data/sources/verify_mobile_number_service/verify_mobile_number_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/manager_id_repository/manager_id_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/verify_mobile_number_repository/verify_mobile_number_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/storage/shared_pref_manager.dart';
import '../../models/response_model/response_model.dart';

class ManageridRepositoryImpl implements ManagerIdRepository {
  final ManagerIdService _managerIdService;
  ManageridRepositoryImpl(this._managerIdService);

  @override
  Future<DataState<ResponseModel>> getManagerIdRepository() async {
    final userId = await SharedPrefManager().getUserId();
    try {
      final httpResponse = await _managerIdService.getManagerId(customerId: userId);
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
