part of 'notifications_socket_cubit.dart';

abstract class NotificationsSocketState extends Equatable {
  const NotificationsSocketState();

  @override
  List<Object?> get props => [];
}

class NotificationsSocketInitial extends NotificationsSocketState {}

class NotificationsSocketLoading extends NotificationsSocketState {}

class NotificationsSocketSuccess extends NotificationsSocketState {
  final List<NotificationModel> notifications;

  const NotificationsSocketSuccess({required this.notifications});

  @override
  List<Object?> get props => [notifications];
}

class NotificationsSocketError extends NotificationsSocketState {
  final String message;

  const NotificationsSocketError(this.message);

  @override
  List<Object?> get props => [message];
}

class NewNotificationReceived extends NotificationsSocketState {
  final List<NotificationModel> notifications;

  const NewNotificationReceived({required this.notifications});

  @override
  List<Object?> get props => [notifications];
}
