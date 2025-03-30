
part of 'events_cubit.dart';

abstract class EventsState extends Equatable {
  final List<EventsModel>? eventsList;
  final DioException? error;

  const EventsState({this.eventsList, this.error});

  @override
  List<Object?> get props => [eventsList, error];
}

class EventsInitialState extends EventsState {
  const EventsInitialState({List<EventsModel>? eventsList, DioException? error})
      : super(eventsList: eventsList, error: error);
}

class EventsLoadedState extends EventsState {
  const EventsLoadedState({List<EventsModel>? eventsList, DioException? error})
      : super(eventsList: eventsList, error: error);
}

class EventsErrorState extends EventsState {
  const EventsErrorState({ DioException? error})
      : super( error: error);
}

