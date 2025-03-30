// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FCMTokenRegisterModel _$FCMTokenRegisterModelFromJson(
        Map<String, dynamic> json) =>
    FCMTokenRegisterModel(
      Token: json['Token'] as String?,
      CustomerID: json['CustomerID'] as String?,
    );

Map<String, dynamic> _$FCMTokenRegisterModelToJson(
        FCMTokenRegisterModel instance) =>
    <String, dynamic>{
      'Token': instance.Token,
      'CustomerID': instance.CustomerID,
    };
