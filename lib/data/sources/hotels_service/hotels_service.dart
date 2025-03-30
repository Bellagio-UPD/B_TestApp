import 'package:bellagio_mobile_user/core/constants/urls.dart';
import 'package:bellagio_mobile_user/data/models/hotels_model/hotels_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'hotels_service.g.dart';

@RestApi(baseUrl: urlMstDtaMgt)
abstract class HotelsService {
  factory HotelsService(Dio dio) = _HotelsService;

  @GET('/findall/hotel')
  Future<HttpResponse<List<HotelsModel>>> getAllHotels();
}