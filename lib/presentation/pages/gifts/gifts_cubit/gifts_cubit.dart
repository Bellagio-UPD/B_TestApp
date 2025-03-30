import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/gifts_model/gifts_model_new.dart';
import 'package:bellagio_mobile_user/domain/usecases/gifts_usecase/get_gifts_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/gifts_model/gifts_model.dart';

part 'gifts_state.dart';

class GiftsCubit extends Cubit<GiftsState> {
  final GetGiftsUsecase? getGiftsUsecase;

  GiftsCubit({this.getGiftsUsecase}) : super(GiftsInitialState());

  Future<void> getGifts() async {
    try {
      final giftslist = await getGiftsUsecase!.call(params: null);
      if (giftslist is DataSuccess) {
        emit(GiftsLoadedState(
            giftsList: giftslist.data, error: giftslist.error));
      } else {
        if (giftslist.data == null || giftslist.data!.isEmpty) {
          emit(GiftsLoadedState(
              giftsList: giftslist.data, error: giftslist.error));
        } else {
          emit(GiftsErrorState(error: giftslist.error));
        }
      }
    } on DioException catch (e) {
      emit(GiftsErrorState(error: e));
    }
  }
}
