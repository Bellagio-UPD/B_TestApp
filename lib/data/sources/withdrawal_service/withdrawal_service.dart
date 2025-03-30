import 'package:bellagio_mobile_user/core/constants/urls.dart';
import 'package:bellagio_mobile_user/data/models/withdrawals_model/withdrawal_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'withdrawal_service.g.dart';

@RestApi(baseUrl: urlTrnMgt)
abstract class WithdrawalService {
  factory WithdrawalService(Dio dio) = _WithdrawalService;

  @GET('/findallif/withdrawalsbycustomerid/customerid')
  Future<HttpResponse<List<WithdrawalModel>>> getWithdrawals({
    @Query("CustomerId") String? customerId,
    @Query("Status") String? status
  });
}