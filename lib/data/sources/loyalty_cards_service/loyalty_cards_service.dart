import 'package:bellagio_mobile_user/data/models/loyalty_cards_model/loyalty_cards_model.dart';
import 'package:bellagio_mobile_user/data/models/packages_model/packages_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';

part 'loyalty_cards_service.g.dart';

@RestApi(baseUrl: urlLytMgt)
abstract class LoyaltyCardsService {
  factory LoyaltyCardsService(Dio dio) = _LoyaltyCardsService;

  @GET('/findall/loyaltyprogram')
  Future<HttpResponse<List<LoyaltyCardsModel>>> getAllLoyaltyCards();

  @GET('/find/loyaltyprogram')
  Future<HttpResponse<LoyaltyCardsModel>> getLoyaltyCard({
    @Query("loyaltyProgramId") String? loyaltyProgramId
  });
}
