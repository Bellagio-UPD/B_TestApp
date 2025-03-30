import 'dart:io';

import 'package:bellagio_mobile_user/data/models/airports_model/airports_model.dart';
import 'package:bellagio_mobile_user/data/sources/airports_service/airports_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/airports_repository/airports_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/storage/data_state.dart';

class AirportsRepositoryImpl implements AirportsRepository {
  final AirportsService _airportsService;
  AirportsRepositoryImpl(this._airportsService);

  @override
  Future<DataState<List<AirportModel>>> getAllAirports() async {
    try {
      final httpResponse = await _airportsService.getAllAirports();
      if (httpResponse.response.statusCode == HttpStatus.accepted) {
        final data = httpResponse.response.data;
        final airportsList = (data as List)
            .map((e) => AirportModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return DataSuccess(airportsList);
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
