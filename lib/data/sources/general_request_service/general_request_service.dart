
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';
import '../../models/general_request_model/general_request_model.dart';
import '../../models/response_model/response_model.dart';

part 'general_request_service.g.dart';

@RestApi(baseUrl: baseURL)
abstract class GeneralRequestService {
  factory GeneralRequestService(Dio dio) = _GeneralRequestService;

  @POST('/customerrequestmanagement-app1665/create/customerrequest')
  Future<HttpResponse<ResponseModel>> createGeneralRequest(
    @Body() GeneralRequestModel generalRequestModel
  );
}
