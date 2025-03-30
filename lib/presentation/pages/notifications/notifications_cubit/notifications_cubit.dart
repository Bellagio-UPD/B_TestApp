// import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/domain/usecases/notifications_usecase/get_notifications_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/offers_usecase/get_offers_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/data_state.dart';
import '../../../../data/models/notifications_model/notifications_model.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final GetNotificationsUsecase? getNotificationsUsecase;
  int _page = 1;
  final int _limit = 10;
  bool _hasMore = true;
  bool _isLoading = false;

  List<NotificationModel>? _notificationsList = [];
  NotificationsCubit({this.getNotificationsUsecase}) : super(NotificationsInitialState());

  Future<void> getNotifications({bool isLoadMore = false}) async {
    if (_isLoading || (!_hasMore && isLoadMore)) return;
    _isLoading = true;

    if (!isLoadMore) {
      _page = 1;
      _notificationsList?.clear();
      _hasMore = true;
    }

    try {
      final notificationsList =
          await getNotificationsUsecase!.call(_page, _limit);

      if (notificationsList is DataSuccess) {
        final newNotifications = notificationsList.data ?? [];

        if (newNotifications.isEmpty) {
          _hasMore = false;
        } else {
          _page++;
          _notificationsList?.addAll(newNotifications);
        }

        // Emit the loaded notifications list even when there are no more to load
        emit(NotificationsLoadedState(
          notificationList: List.from(_notificationsList!),
          error: notificationsList.error,
        ));
      } else {
        if (_notificationsList!.isEmpty) {
          _hasMore = false;
          emit(NotificationsErrorState(error: notificationsList.error));
        }
      }
    } catch (e) {
      emit(NotificationsErrorState(error: e as DioException));
    } finally {
      _isLoading = false;
    }
  }
}