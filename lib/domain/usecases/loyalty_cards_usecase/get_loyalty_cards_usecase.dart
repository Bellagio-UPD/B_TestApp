import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/loyalty_cards_model/loyalty_cards_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/loyalty_cards_repository/loyalty_cards_repository.dart';
import 'package:bellagio_mobile_user/domain/usecases/usecase/usecase.dart';

class GetLoyaltyCardsUsecase
    implements UseCase<DataState<List<LoyaltyCardsModel>>, void> {
  final LoyaltyCardsRepository _loyaltyCardsRepository;

  GetLoyaltyCardsUsecase(this._loyaltyCardsRepository);
  @override
  Future<DataState<List<LoyaltyCardsModel>>> call({void params}) {
    return _loyaltyCardsRepository.getLoyaltyCards();
  }
}
