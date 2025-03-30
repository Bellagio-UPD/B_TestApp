part of 'airports_cubit.dart';

abstract class AirportsState extends Equatable {
  final List<AirportModel>? airportsList;
  final DioException? error;

  AirportsState({this.airportsList, this.error});

  @override
  List<Object?> get props => [airportsList, error];
}

class AirportInitialState extends AirportsState {
  AirportInitialState(
      {List<AirportModel>? airportInfoList, DioException? error})
      : super(airportsList: airportInfoList, error: error);
}

class AirportLoadedState extends AirportsState {
  AirportLoadedState(
      {List<AirportModel>? airportsList, DioException? error})
      : super(airportsList: airportsList, error: error);
}

class AirportErrorState extends AirportsState {
  AirportErrorState({DioException? error}) : super(error: error);
}