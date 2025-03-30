import 'package:bellagio_mobile_user/data/models/air_tickets_model/air_tickets_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';

part 'air_tickets_service.g.dart';

@RestApi(baseUrl: urlBkgMgt)
abstract class AirTicketsService {
  factory AirTicketsService(Dio dio) = _AirTicketsService;

  @GET('/findallif/airticketbooking/customerid')
  Future<HttpResponse<List<AirTicketModel>>> getAirTicket({
    @Query("CustomerId") String? customerId
});
}