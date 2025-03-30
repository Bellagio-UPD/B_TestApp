import 'package:bellagio_mobile_user/data/models/notifications_model/notifications_model.dart';
import '../../../core/storage/data_state.dart';

abstract class NotificationsRepository {
  Future<DataState<List<NotificationModel>>> getNotifications({int page, int limit});
  Stream<List<NotificationModel>> getNotificationsBySocket();
}
