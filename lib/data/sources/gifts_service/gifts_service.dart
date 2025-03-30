import 'package:bellagio_mobile_user/data/models/gifts_model/gifts_model.dart';
import 'package:bellagio_mobile_user/data/models/gifts_model/gifts_model_new.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';

part 'gifts_service.g.dart';

@RestApi(baseUrl: urlCstmReqMgt)
abstract class GiftsService {
  factory GiftsService(Dio dio) = _GiftsService;

  @GET('/findallif/customergiftbycustomerid/customerid')
  Future<HttpResponse<List<GiftsModelNew>>> getGifts(
      {@Query("CustomerId") String? customerId});
}
