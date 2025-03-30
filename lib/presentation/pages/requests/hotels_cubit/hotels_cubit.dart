import 'package:bellagio_mobile_user/domain/usecases/hotels_usecase/get_hotels_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/data_state.dart';
import '../../../../data/models/hotels_model/hotels_model.dart';

part 'hotels_state.dart';

class HotelsCubit extends Cubit<HotelsState> {
  final GetHotelsUsecase? getHotelsUsecase;

  HotelsCubit({this.getHotelsUsecase}) : super(HotelsInitialState());

  Future<void> getHotels() async {
    try {
      final loadHotels = await getHotelsUsecase!.call(params: null);
      if (loadHotels is DataSuccess || loadHotels.data != null) {
        emit(HotelsLoadedState(
            hotelList: loadHotels.data, error: loadHotels.error));
      } else {
        emit(HotelsErrorState(error: loadHotels.error));
      }
    } on DioException catch (e) {
      emit(HotelsErrorState(error: e));
    }
  }
}
