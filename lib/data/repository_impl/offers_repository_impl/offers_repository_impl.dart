import 'dart:io';

import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/core/storage/shared_pref_manager.dart';
import 'package:bellagio_mobile_user/data/models/offers_model/offers_model.dart';
import 'package:bellagio_mobile_user/data/sources/offers_service/offers_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/offers_repository/offers_repository.dart';
import 'package:dio/dio.dart';

class OffersRepositoryImpl implements OffersRepository {
  final OffersService _offersService;
  OffersRepositoryImpl(this._offersService);
  final sharedPrefManager = SharedPrefManager();
  
  @override
  Future<DataState<List<OffersModel>>> getOffersRepository() async {
    final loyaltyProgramId =
        await sharedPrefManager.getLoyaltyProgramId();
    try {
      final httpResponse =
          await _offersService.getAllOffers(loyaltyProgramId: loyaltyProgramId);
      if (httpResponse.response.statusCode == HttpStatus.accepted) {
        final data = httpResponse.response.data;
        final offersList = (data as List)
            .map((e) => OffersModel.fromJson(e as Map<String, dynamic>))
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
