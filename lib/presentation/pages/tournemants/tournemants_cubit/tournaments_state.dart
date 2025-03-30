part of 'tournaments_cubit.dart';

abstract class TournamentsState extends Equatable {
  final List<TournamentsModel>? tournamentList;
  final DioException? error;

  const TournamentsState({this.tournamentList, this.error});

  @override
  List<Object?> get props => [tournamentList, error];
}

class TournamentsInitialState extends TournamentsState {
  const TournamentsInitialState({List<TournamentsModel>? tournamentsList, DioException? error})
      : super(tournamentList: tournamentsList, error: error);
}

class TournamentsLoadedState extends TournamentsState {
  const TournamentsLoadedState({List<TournamentsModel>? tournamentList, DioException? error})
      : super(tournamentList: tournamentList, error: error);
}

class TournamentsErrorState extends TournamentsState {
  const TournamentsErrorState({ DioException? error})
      : super( error: error);
}

