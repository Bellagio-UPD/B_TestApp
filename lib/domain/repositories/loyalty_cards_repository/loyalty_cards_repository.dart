import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/loyalty_cards_model/loyalty_cards_model.dart';

abstract class LoyaltyCardsRepository {
  Future<DataState<List<LoyaltyCardsModel>>> getLoyaltyCards();
  Future<DataState<LoyaltyCardsModel>> getLoyaltyCard();
}
