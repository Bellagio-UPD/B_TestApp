import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/notifications_model/notifications_model.dart';
import '../../../../data/sources/notifications_service/notifications_socket_service.dart';
import '../../../../domain/repositories/notifications_repository/notifications_repository.dart';
import '../../../../domain/usecases/notifications_usecase/get_notifications_by_socket_usecase.dart';

part 'notifications_socket_state.dart';

class NotificationsSocketCubit extends Cubit<NotificationsSocketState> {
  final NotificationsRepository? _repository;
  final GetNotificationsBySocketUseCase? _socketUseCase;
  StreamSubscription? _socketSubscription;
  final NotificationsSocketService? _socketService;

  NotificationsSocketCubit(
    this._repository,
    this._socketUseCase,
    this._socketService,
  ) : super(NotificationsSocketInitial());

  Future<void> fetchNotificationsSocket() async {
    emit(NotificationsSocketLoading());

    await _socketService!.connect(); // Ensure connection is established

    await _socketSubscription?.cancel();

    _socketSubscription = _socketUseCase!.call().listen(
      (notifications) {
        emit(NotificationsSocketSuccess(notifications: notifications));
      },
      onError: (error) {
        emit(NotificationsSocketError('Socket error: $error'));
      },
    );
  }

  @override
  Future<void> close() {
    _socketSubscription?.cancel();
    return super.close();
  }
}
