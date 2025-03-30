part of 'loyalty_cards_cubit.dart';

abstract class LoyaltyCardState extends Equatable {
  final List<LoyaltyCardsModel>? cardsList;
  final LoyaltyCardsModel? loyaltyCard;
  final DioException? error;

  const LoyaltyCardState({this.cardsList, this.error, this.loyaltyCard});

  @override
  List<Object?> get props => [cardsList, error];
}

class LoyaltyCardsInitialState extends LoyaltyCardState {
  const LoyaltyCardsInitialState(
      {List<LoyaltyCardsModel>? cardsList, DioException? error})
      : super(cardsList: cardsList, error: error);
}

class LoyaltyCardsLoadedState extends LoyaltyCardState {
  const LoyaltyCardsLoadedState(
      {List<LoyaltyCardsModel>? cardsList, DioException? error})
      : super(cardsList: cardsList, error: error);
}

class LoyaltyCardsErrorState extends LoyaltyCardState {
  const LoyaltyCardsErrorState({DioException? error}) : super(error: error);
}

class LoyaltyCardInitialState extends LoyaltyCardState {
  const LoyaltyCardInitialState(
      {LoyaltyCardsModel? loyaltyCard, DioException? error})
      : super(loyaltyCard: loyaltyCard, error: error);
}

class LoyaltyCardLoadedState extends LoyaltyCardState {
  const LoyaltyCardLoadedState(
      {LoyaltyCardsModel? loyaltyCard, DioException? error})
      : super(loyaltyCard: loyaltyCard, error: error);
}

class LoyaltyCardErrorState extends LoyaltyCardState {
  const LoyaltyCardErrorState({DioException? error}) : super(error: error);
}
