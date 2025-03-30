// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventsModel _$EventsModelFromJson(Map<String, dynamic> json) => EventsModel(
      EventId: json['EventId'] as String?,
      Name: json['Name'] as String?,
      Date: json['Date'] as String?,
      Description: json['Description'] as String?,
      Category: json['Category'] as String?,
      Status: json['Status'] as String?,
      Poster:
          (json['Poster'] as List<dynamic>?)?.map((e) => e as String).toList(),
      Deleted: json['Deleted'] as bool?,
    );

Map<String, dynamic> _$EventsModelToJson(EventsModel instance) =>
    <String, dynamic>{
      'EventId': instance.EventId,
      'Name': instance.Name,
      'Date': instance.Date,
      'Description': instance.Description,
      'Category': instance.Category,
      'Status': instance.Status,
      'Poster': instance.Poster,
      'Deleted': instance.Deleted,
    };
