import 'package:bellagio_mobile_user/data/models/notifications_model/notifications_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';

part 'notifications_service.g.dart';

@RestApi(baseUrl: urlNtfMgt)
abstract class NotificationsService {
  factory NotificationsService(Dio dio) = _NotificationsService;

  @GET('/find/MessageByRecipient')
  Future<HttpResponse<List<NotificationModel>>> getNotifications({
    @Query("reciever") String? customerId,
    @Query("page") int? page,
    @Query("limit") int? limit,
  });
}