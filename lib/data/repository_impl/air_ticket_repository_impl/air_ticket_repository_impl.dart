import 'dart:io';

import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/air_tickets_model/air_tickets_model.dart';
import 'package:bellagio_mobile_user/data/sources/air_tickets_service/air_tickets_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/air_tickets_repository/air_tickets_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/storage/shared_pref_manager.dart';

class AirTicketRepositoryImpl implements AirTicketsRepository {
  final AirTicketsService _airTicketsService;
  AirTicketRepositoryImpl(this._airTicketsService);

  @override
  Future<DataState<List<AirTicketModel>>> getAirTicketInfo() async {
    final userId = await SharedPrefManager().getUserId();
    try {
      final httpResponse =
          await _airTicketsService.getAirTicket(customerId: userId);
      if (httpResponse.response.statusCode == HttpStatus.accepted) {
        final data = httpResponse.response.data;
        final airTicketInfo = (data as List)
            .map((e) => AirTicketModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return DataSuccess(airTicketInfo);
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
