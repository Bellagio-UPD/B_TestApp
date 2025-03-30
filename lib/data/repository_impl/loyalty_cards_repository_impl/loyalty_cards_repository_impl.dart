import 'dart:io';

import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/loyalty_cards_model/loyalty_cards_model.dart';
import 'package:bellagio_mobile_user/data/sources/loyalty_cards_service/loyalty_cards_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/loyalty_cards_repository/loyalty_cards_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/storage/shared_pref_manager.dart';

class LoyaltyCardsRepositoryImpl implements LoyaltyCardsRepository {
  final LoyaltyCardsService _loyaltyCardsService;
   final sharedPrefManager = SharedPrefManager();

  LoyaltyCardsRepositoryImpl(this._loyaltyCardsService);

  @override
  Future<DataState<List<LoyaltyCardsModel>>> getLoyaltyCards() async {
    try {
      final httpResponse = await _loyaltyCardsService.getAllLoyaltyCards();
      if (httpResponse.response.statusCode == HttpStatus.accepted) {
        final data = httpResponse.response.data;
        final loyaltyCardList = (data as List)
            .map((e) => LoyaltyCardsModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return DataSuccess(loyaltyCardList);
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

  @override
  Future<DataState<LoyaltyCardsModel>> getLoyaltyCard() async {
     final loyaltyProgramId =
        await sharedPrefManager.getLoyaltyProgramId();
    try {
      final httpResponse = await _loyaltyCardsService.getLoyaltyCard(loyaltyProgramId: loyaltyProgramId);
      if (httpResponse.response.statusCode == HttpStatus.accepted||httpResponse.response.statusCode == HttpStatus.ok) {
        // final loyaltyCard = (data as List)
        //     .map((e) => LoyaltyCardsModel.fromJson(e as Map<String, dynamic>))
        //     .toList();
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
