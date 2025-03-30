import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/domain/usecases/offers_usecase/get_offers_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/offers_model/offers_model.dart';

part 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  final GetOffersUsecase? getOffersUsecase;

  OffersCubit({this.getOffersUsecase}) : super(OffersInitialState());

  Future<void> getOffers() async {
    try {
      final offersList = await getOffersUsecase!.call(params: null);
      if (offersList is DataSuccess) {
        emit(OffersLoadedState(
            offersList: offersList.data, error: offersList.error));
      } else {
        if (offersList.data == null || offersList.data!.isEmpty) {
          emit(OffersLoadedState(
              offersList: offersList.data, error: offersList.error));
        } else {
          emit(OffersErrorState(error: offersList.error));
        }
      }
    } on DioException catch (e) {
      emit(OffersErrorState(error: e));
    }
  }
}
