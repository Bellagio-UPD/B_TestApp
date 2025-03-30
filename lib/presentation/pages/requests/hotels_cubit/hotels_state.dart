part of 'hotels_cubit.dart';

abstract class HotelsState extends Equatable {
  final List<HotelsModel>? hotelList;
  final DioException? error;

  const HotelsState({this.hotelList, this.error});

  @override
  List<Object?> get props => [hotelList, error];
}

class HotelsInitialState extends HotelsState {
  const HotelsInitialState(
      {List<HotelsModel>? hotelList, DioException? error})
      : super(error: error, hotelList: hotelList);
}

class HotelsLoadedState extends HotelsState {
  const HotelsLoadedState(
      {List<HotelsModel>? hotelList, DioException? error})
      : super(error: error, hotelList: hotelList);
}

class HotelsErrorState extends HotelsState {
  const HotelsErrorState({DioException? error}) : super(error: error);
}
