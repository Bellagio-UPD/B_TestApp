import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';
import '../../models/response_model/response_model.dart';

part 'manager_id_service.g.dart';

@RestApi(baseUrl: urlCstmReqMgt)
abstract class ManagerIdService {
  factory ManagerIdService(Dio dio) = _ManagerIdService;

    @GET('/FindManagerIdByCustomerId')
  Future<HttpResponse<ResponseModel>> getManagerId({
    @Query("customerId") String? customerId
  });
}
