import 'package:bellagio_mobile_user/data/models/notifications_model/notifications_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/notifications_repository/notifications_repository.dart';

class GetNotificationsBySocketUseCase {
  final NotificationsRepository repository;

  GetNotificationsBySocketUseCase({required this.repository});

  Stream<List<NotificationModel>> call() {
    return repository.getNotificationsBySocket();
  }
}