import 'package:bellagio_mobile_user/core/constants/urls.dart';
import 'package:bellagio_mobile_user/data/models/feedback_model/feedback_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/response_model/response_model.dart';

part 'feedback_service.g.dart';

@RestApi(baseUrl: urlCstmReqMgt)
abstract class FeedbackService {
  factory FeedbackService(Dio dio) = _FeedbackService;

  @POST('/create/feedback')
  Future<HttpResponse<ResponseModel>> createFeedback(
    @Body() FeedbackModel feedbackModel
  );
}