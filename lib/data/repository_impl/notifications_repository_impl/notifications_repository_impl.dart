import 'dart:convert';
import 'dart:io';
import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/core/storage/shared_pref_manager.dart';
import 'package:bellagio_mobile_user/data/models/notifications_model/notifications_model.dart';
import 'package:bellagio_mobile_user/data/sources/notifications_service/notifications_service.dart';
import 'package:bellagio_mobile_user/data/sources/notifications_service/notifications_socket_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/notifications_repository/notifications_repository.dart';
import 'package:dio/dio.dart';

import '../../../domain/entities/notifications_entity/notifications_entity.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsService _notificationsService;
  final NotificationsSocketService notificationsSocketService;
  NotificationsRepositoryImpl(
      this._notificationsService, this.notificationsSocketService);
  final sharedPrefManager = SharedPrefManager();

  @override
  Future<DataState<List<NotificationModel>>> getNotifications({int? page, int? limit}) async {
    final customerId = await sharedPrefManager.getUserId();
    try {
      final httpResponse =
          await _notificationsService.getNotifications(customerId: customerId, page: page,limit: limit);
      if (httpResponse.response.statusCode == HttpStatus.accepted || httpResponse.response.statusCode == HttpStatus.ok) {
        final data = httpResponse.response.data;
        final notificationList = (data as List)
            .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return DataSuccess(notificationList);
      } else {
        return DataFailed(DioException(
            type: DioExceptionType.badResponse,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
            error: httpResponse.response));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
Stream<List<NotificationModel>> getNotificationsBySocket() {
  try {
    return notificationsSocketService.notificationsStream.map((event) {
      if (event is List) {
        return event.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        return [];
      }
    });
  } catch (e) {
    throw Exception('Failed to get notifications by socket: $e');
  }
}

}
