import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';
import '../../models/offers_model/offers_model.dart';

part 'offers_service.g.dart';

@RestApi(baseUrl: urlLytMgt)
abstract class OffersService {
  factory OffersService(Dio dio) = _OffersService;

  @GET('/findallif/offerbyloyaltyprogramid/loyaltyprogramid')
  Future<HttpResponse<List<OffersModel>>> getAllOffers({
    @Query("LoyaltyProgramId") String? loyaltyProgramId
  });
}
