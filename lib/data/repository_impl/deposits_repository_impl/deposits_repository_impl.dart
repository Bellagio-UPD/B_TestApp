import 'dart:io';

import 'package:bellagio_mobile_user/data/models/deposits_model/deposits_model.dart';
import 'package:bellagio_mobile_user/data/sources/deposits_service/deposits_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/deposits_repository/deposits_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/storage/data_state.dart';
import '../../../core/storage/shared_pref_manager.dart';

class DepositsRepositoryImpl implements DepositsRepository {
  final DepositsService _depositsService;
  DepositsRepositoryImpl(this._depositsService);
   final sharedPrefManager = SharedPrefManager();

  @override
  Future<DataState<List<DepositModel>>> getDeposits() async {
    try {
          final customerId =
        await sharedPrefManager.getUserId();
      final httpResponse = await _depositsService.getDeposits(customerId: customerId,status: "Approved");
      if (httpResponse.response.statusCode == HttpStatus.accepted) {
        final data = httpResponse.response.data;
        final eventsList = (data as List)
            .map((e) => DepositModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return DataSuccess(eventsList);
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