import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';
import '../../models/events_model/events_model.dart';

part 'events_service.g.dart';

@RestApi(baseUrl: urlEvtMgt)
abstract class EventsService {
  factory EventsService(Dio dio) = _EventsService;

  @GET('/findall/event')
  Future<HttpResponse<List<EventsModel>>> getAllEvents();
}