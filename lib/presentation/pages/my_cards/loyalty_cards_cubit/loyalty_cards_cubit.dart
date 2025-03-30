import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/domain/usecases/loyalty_cards_usecase/get_assigned_loyalty_card_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/loyalty_cards_usecase/get_loyalty_cards_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/shared_pref_manager.dart';
import '../../../../data/models/loyalty_cards_model/loyalty_cards_model.dart';

part 'loyalty_card_state.dart';

class LoyaltyCardsCubit extends Cubit<LoyaltyCardState> {
  final GetLoyaltyCardsUsecase? getLoyaltyCardsUsecase;
  final GetAssignedLoyaltyCardsUsecase? getAssignedLoyaltyCardsUsecase;

  LoyaltyCardsCubit(
      {this.getLoyaltyCardsUsecase, this.getAssignedLoyaltyCardsUsecase})
      : super(LoyaltyCardsInitialState());

  Future<void> getLoyaltyCards() async {
    emit(LoyaltyCardsInitialState());
    try {
      final cardsList = await getLoyaltyCardsUsecase!.call(params: null);
      if (cardsList is DataSuccess || cardsList.data != null) {
        emit(LoyaltyCardsLoadedState(
            cardsList: cardsList.data, error: cardsList.error));
      } else {
        emit(LoyaltyCardsErrorState(error: cardsList.error));
      }
    } on DioException catch (e) {
      emit(LoyaltyCardsErrorState(error: e));
    }
  }

  Future<void> getLoyaltCard() async {
    emit(LoyaltyCardInitialState());
    try {
      final card = await getAssignedLoyaltyCardsUsecase!.call(params: null);

      final loyaltyProgramId = await SharedPrefManager().getLoyaltyProgramId();
      if (loyaltyProgramId == null || loyaltyProgramId == '') {
        emit(LoyaltyCardErrorState(error: card.error));
        return;
      } else {
        if (card.data is DataSuccess || card.data != null) {
          emit(LoyaltyCardLoadedState(
              loyaltyCard: card.data, error: card.error));
        } else {
          emit(LoyaltyCardErrorState(error: card.error));
        }
      }
    } on DioException catch (e) {
      emit(LoyaltyCardErrorState(error: e));
    }
  }
}
