part of 'gifts_cubit.dart';

abstract class GiftsState extends Equatable{
  final List<GiftsModelNew>? giftsList;
  final DioException? error;

  GiftsState({this.giftsList,this.error});

  @override
  List<Object?> get props => [giftsList, error];
}

class GiftsInitialState extends GiftsState {
   GiftsInitialState({List<GiftsModelNew>? giftsList, DioException? error}): super(giftsList: giftsList,error: error);
}

class GiftsLoadedState extends GiftsState {
   GiftsLoadedState({List<GiftsModelNew>? giftsList, DioException? error}): super(giftsList: giftsList,error: error);
}

class GiftsErrorState extends GiftsState {
   GiftsErrorState({List<GiftsModelNew>? giftsList, DioException? error}): super(giftsList: giftsList,error: error);
}

