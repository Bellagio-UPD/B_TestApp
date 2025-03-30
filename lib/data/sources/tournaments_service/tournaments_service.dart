import 'package:bellagio_mobile_user/data/models/tournaments_model/tournaments_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';

part 'tournaments_service.g.dart';

@RestApi(baseUrl: urlEvtMgt)
abstract class TournamentsService {
  factory TournamentsService(Dio dio) = _TournamentsService;

  @GET('/findall/tournament')
  Future<HttpResponse<List<TournamentsModel>>> getAllTournaments();
}