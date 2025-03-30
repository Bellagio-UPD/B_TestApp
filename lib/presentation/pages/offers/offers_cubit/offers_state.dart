part of 'offers_cubit.dart';

abstract class OffersState extends Equatable {
  final List<OffersModel>? offersList;
  final DioException? error;

  OffersState({this.offersList, this.error});

  @override
  List<Object?> get props => [offersList, error];
}

class OffersInitialState extends OffersState {
  OffersInitialState({List<OffersModel>? offersList, DioException? error})
      : super(offersList: offersList, error: error);
}

class OffersLoadedState extends OffersState {
  OffersLoadedState({List<OffersModel>? offersList, DioException? error})
      : super(offersList: offersList, error: error);
}

class OffersErrorState extends OffersState {
  OffersErrorState({DioException? error}) : super(error: error);
}
