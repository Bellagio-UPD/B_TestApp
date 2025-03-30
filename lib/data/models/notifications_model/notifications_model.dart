import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/notifications_entity/notifications_entity.dart';

part 'notifications_model.g.dart';

@JsonSerializable()
class NotificationModel extends NotificationsEntity {
  const NotificationModel({
    super.Content,
    super.MessageId,
    super.NotificationType,
    super.Receiver,
    super.RecieverContact,
    super.Sender,
    super.ServiceProvider,
    super.Subject,
    super.TimeStamp,
    super.Deleted
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
