import 'package:bellagio_mobile_user/data/models/notifications_model/notifications_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/notifications_repository/notifications_repository.dart';
import 'package:bellagio_mobile_user/domain/usecases/usecase/usecase.dart';

import '../../../core/storage/data_state.dart';

class GetNotificationsUsecase  {
  final NotificationsRepository _notificationsRepository;

  GetNotificationsUsecase(this._notificationsRepository);
  @override
  Future<DataState<List<NotificationModel>>> call(int page, int limit) {
    return _notificationsRepository.getNotifications(page: page,limit: limit);
  }
}