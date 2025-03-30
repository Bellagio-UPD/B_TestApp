import 'package:bellagio_mobile_user/data/models/airports_model/airports_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';

part 'airports_service.g.dart';

@RestApi(baseUrl: urlBkgMgt)
abstract class AirportsService {
  factory AirportsService(Dio dio) = _AirportsService;

  @GET('/findall/airports')
  Future<HttpResponse<List<AirportModel>>> getAllAirports();
}
