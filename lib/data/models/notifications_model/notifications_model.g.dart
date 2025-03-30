// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      Content: json['Content'] as String?,
      MessageId: json['MessageId'] as String?,
      NotificationType: json['NotificationType'] as String?,
      Receiver: json['Receiver'] as String?,
      RecieverContact: json['RecieverContact'] as String?,
      Sender: json['Sender'] as String?,
      ServiceProvider: json['ServiceProvider'] as String?,
      Subject: json['Subject'] as String?,
      TimeStamp: json['TimeStamp'] as String?,
      Deleted: json['Deleted'] as bool?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'MessageId': instance.MessageId,
      'Content': instance.Content,
      'Sender': instance.Sender,
      'Receiver': instance.Receiver,
      'RecieverContact': instance.RecieverContact,
      'TimeStamp': instance.TimeStamp,
      'NotificationType': instance.NotificationType,
      'Subject': instance.Subject,
      'ServiceProvider': instance.ServiceProvider,
      'Deleted': instance.Deleted,
    };
