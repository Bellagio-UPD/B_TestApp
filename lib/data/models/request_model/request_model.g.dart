// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestModel _$RequestModelFromJson(Map<String, dynamic> json) => RequestModel(
      RequestId: json['RequestId'] as String?,
      Title: json['Title'] as String?,
      Status: json['Status'] as String?,
      Details: json['Details'] == null
          ? null
          : DetailsEntity.fromJson(json['Details'] as Map<String, dynamic>),
      Priority: json['Priority'] as String?,
      RequestedDate: json['RequestedDate'] as String?,
      DateOfCompletion: json['DateOfCompletion'] as String?,
      CustomerId: json['CustomerId'] as String?,
      CustomerName: json['CustomerName'] as String?,
      RequestType: json['RequestType'] as String?,
      RejectReason: json['RejectReason'] as String?,
      PResponder: json['PResponder'] as String?,
      SResponder: json['SResponder'] as String?,
      Delay: json['Delay'] as String?,
      Descriptions: json['Descriptions'] as String?,
      IsLongTrip: json['IsLongTrip'] as bool?,
    );

Map<String, dynamic> _$RequestModelToJson(RequestModel instance) =>
    <String, dynamic>{
      'RequestId': instance.RequestId,
      'Title': instance.Title,
      'Status': instance.Status,
      'Details': instance.Details,
      'Priority': instance.Priority,
      'RequestedDate': instance.RequestedDate,
      'DateOfCompletion': instance.DateOfCompletion,
      'CustomerId': instance.CustomerId,
      'CustomerName': instance.CustomerName,
      'RequestType': instance.RequestType,
      'RejectReason': instance.RejectReason,
      'PResponder': instance.PResponder,
      'SResponder': instance.SResponder,
      'Delay': instance.Delay,
      'Descriptions': instance.Descriptions,
      'IsLongTrip': instance.IsLongTrip,
    };
