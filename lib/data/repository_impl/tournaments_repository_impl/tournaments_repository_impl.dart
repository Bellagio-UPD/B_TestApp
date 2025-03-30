import 'dart:io';

import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/tournaments_model/tournaments_model.dart';
import 'package:bellagio_mobile_user/data/sources/tournaments_service/tournaments_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/tournaments_repository/tournaments_repository.dart';
import 'package:dio/dio.dart';

class TournamentsRepositoryImpl implements TournamentsRepository {
  final TournamentsService _tournamentsService;

  TournamentsRepositoryImpl(this._tournamentsService);

  @override
  Future<DataState<List<TournamentsModel>>> getTournamentsRepository() async {
    try {
      final httpResponse = await _tournamentsService.getAllTournaments();
      if (httpResponse.response.statusCode == HttpStatus.accepted) {
        final data = httpResponse.response.data;
        final tournamentsList = (data as List)
            .map((e) => TournamentsModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return DataSuccess(tournamentsList);
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
