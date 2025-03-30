import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/domain/usecases/events_usecase/get_events_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/events_model/events_model.dart';

part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  final GetEventsUsecase? getEventsUsecase;

  EventsCubit({this.getEventsUsecase}) : super(EventsInitialState());

  Future<void> getEvents() async {
    try {
      final allEvents = await getEventsUsecase!.call(params: null);
      if (allEvents is DataSuccess || allEvents.data != null) {
        emit(EventsLoadedState(
            eventsList: allEvents.data, error: allEvents.error));
      } else {
        if (allEvents.data == null || allEvents.data!.isEmpty) {
          emit(EventsLoadedState(
              eventsList: allEvents.data, error: allEvents.error));
        } else {
          emit(EventsErrorState(error: allEvents.error));
        }
      }
    } on DioException catch (e) {
      emit(EventsErrorState(error: e));
    }
  }
}
