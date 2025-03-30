import 'dart:io';

import 'package:bellagio_mobile_user/data/models/events_model/events_model.dart';
import 'package:bellagio_mobile_user/data/sources/events_service/events_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/events_repository/events_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/storage/data_state.dart';

class EventsRepositoryImpl implements EventsRepository {
  final EventsService _eventsService;
  EventsRepositoryImpl(this._eventsService);

  @override
  Future<DataState<List<EventsModel>>> getEventsRepository() async {
    try {
      final httpResponse = await _eventsService.getAllEvents();
      if (httpResponse.response.statusCode == HttpStatus.accepted) {
        final data = httpResponse.response.data;
        final eventsList = (data as List)
            .map((e) => EventsModel.fromJson(e as Map<String, dynamic>))
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
