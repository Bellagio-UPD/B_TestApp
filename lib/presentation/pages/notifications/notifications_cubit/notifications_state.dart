part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  final List<NotificationModel>? notificationList;
  final DioException? error;

  NotificationsState({this.notificationList, this.error});

  @override
  List<Object?> get props => [notificationList, error];
}

class NotificationsInitialState extends NotificationsState {
  NotificationsInitialState({List<NotificationModel>? notificationList, DioException? error})
      : super(notificationList: notificationList, error: error);
}

class NotificationsLoadedState extends NotificationsState {
  NotificationsLoadedState({List<NotificationModel>? notificationList, DioException? error})
      : super(notificationList: notificationList, error: error);
}

class NotificationsErrorState extends NotificationsState {
  NotificationsErrorState({DioException? error}) : super(error: error);
}