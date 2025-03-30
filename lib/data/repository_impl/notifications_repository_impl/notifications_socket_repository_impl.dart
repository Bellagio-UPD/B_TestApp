// import 'dart:convert';
// import 'dart:io';

// import 'package:bellagio_mobile_user/core/storage/data_state.dart';
// import 'package:bellagio_mobile_user/core/storage/shared_pref_manager.dart';
// import 'package:bellagio_mobile_user/data/models/notifications_model/notifications_model.dart';
// import 'package:bellagio_mobile_user/data/sources/notifications_service/notifications_service.dart';
// import 'package:bellagio_mobile_user/data/sources/notifications_service/notifications_socket_service.dart';
// import 'package:bellagio_mobile_user/domain/repositories/notifications_repository/notifications_repository.dart';
// import 'package:dio/dio.dart';

// import '../../../domain/entities/notifications_entity/notifications_entity.dart';

// class NotificationsSocketRepositoryImpl implements NotificationsRepository {
//   final NotificationsSocketService notificationsSocketService;
//   NotificationsSocketRepositoryImpl(this.notificationsSocketService);
//   final sharedPrefManager = SharedPrefManager();

//   @override
//   Stream<NotificationsEntity> getNotificationsBySocket() {
//     return notificationsSocketService.notificationsStream.map((data) {
//       final json = jsonDecode(data);
//       return NotificationsEntity(
//         Subject: json['title'],
//         Content: json['message'],
//       );
//     });
//   }
// }