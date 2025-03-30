part of 'air_ticket_cubit.dart';

abstract class AirTicketsState extends Equatable {
  final List<AirTicketModel>? airTicketInfoList;
  final DioException? error;

  AirTicketsState({this.airTicketInfoList, this.error});

  @override
  List<Object?> get props => [airTicketInfoList, error];
}

class AirTicketInitialState extends AirTicketsState {
  AirTicketInitialState(
      {List<AirTicketModel>? airTicketInfoList, DioException? error})
      : super(airTicketInfoList: airTicketInfoList, error: error);
}

class AirTicketLoadedState extends AirTicketsState {
  AirTicketLoadedState(
      {List<AirTicketModel>? airTicketInfoList, DioException? error})
      : super(airTicketInfoList: airTicketInfoList, error: error);
}

class AirTicketErrorState extends AirTicketsState {
  AirTicketErrorState({DioException? error}) : super(error: error);
}
