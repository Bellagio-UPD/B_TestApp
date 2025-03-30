import 'package:bellagio_mobile_user/core/constants/urls.dart';
import 'package:bellagio_mobile_user/data/models/feedback_model/feedback_model.dart';
import 'package:bellagio_mobile_user/data/models/feedback_model/feedback_table_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/response_model/response_model.dart';

part 'feedback_table_service.g.dart';

@RestApi(baseUrl: urlMstDtaMgt)
abstract class FeedbackTableService {
  factory FeedbackTableService(Dio dio) = _FeedbackTableService;

  @GET('/GetTableData')
  Future<HttpResponse<List<FeedbackTableModel>>> getGamesNTables();
}

