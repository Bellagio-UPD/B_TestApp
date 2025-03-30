import 'dart:io';

import 'package:bellagio_mobile_user/data/models/withdrawals_model/withdrawal_model.dart';
import 'package:bellagio_mobile_user/data/sources/withdrawal_service/withdrawal_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/withdrawal_repository/withdrawal_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/storage/data_state.dart';
import '../../../core/storage/shared_pref_manager.dart';

class WithdrawalRepositoryImpl implements WithdrawalRepository {
  final WithdrawalService _withdrawalService;
  WithdrawalRepositoryImpl(this._withdrawalService);
  final sharedPrefManager = SharedPrefManager();
  
  @override
  Future<DataState<List<WithdrawalModel>>> getWithdrawals() async {
    final customerId =
        await sharedPrefManager.getUserId();
    try {
      final httpResponse =
          await _withdrawalService.getWithdrawals(customerId: customerId,status: "Approved");
      if (httpResponse.response.statusCode == HttpStatus.accepted) {
        final data = httpResponse.response.data;
        final offersList = (data as List)
            .map((e) => WithdrawalModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return DataSuccess(offersList);
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