import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';
import '../../models/request_model/request_model.dart';
import '../../models/response_model/response_model.dart';

part 'request_service.g.dart';

@RestApi(baseUrl: urlCstmReqMgt)
abstract class RequestService {
  factory RequestService(Dio dio) = _RequestService;

  @POST('/create/request')
  Future<HttpResponse<ResponseModel>> createRequest(
    @Body() RequestModel generalRequestModel
  );
}
