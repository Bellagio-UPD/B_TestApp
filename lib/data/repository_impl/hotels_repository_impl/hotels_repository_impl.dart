import 'dart:io';

import 'package:bellagio_mobile_user/data/models/hotels_model/hotels_model.dart';
import 'package:bellagio_mobile_user/data/sources/hotels_service/hotels_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/hotels_repository/hotels_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/storage/data_state.dart';

class HotelsRepositoryImpl implements HotelsRepository {
  final HotelsService _hotelsService;
  HotelsRepositoryImpl(this._hotelsService);

  @override
  Future<DataState<List<HotelsModel>>> getAllHotels() async {
    try {
      final httpResponse = await _hotelsService.getAllHotels();
      if (httpResponse.response.statusCode == HttpStatus.accepted) {
        final data = httpResponse.response.data;
        final giftList = (data as List)
            .map((e) => HotelsModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return DataSuccess(giftList);
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
