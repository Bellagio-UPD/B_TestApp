import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';
import '../../models/deposits_model/deposits_model.dart';

part 'deposits_service.g.dart';

@RestApi(baseUrl: urlTrnMgt)
abstract class DepositsService {
  factory DepositsService(Dio dio) = _DepositsService;

  @GET('/findallif/depositbycustomerid/customerid')
  Future<HttpResponse<List<DepositModel>>> getDeposits(
      {@Query("CustomerId") String? customerId,
      @Query("Status") String? status});
}