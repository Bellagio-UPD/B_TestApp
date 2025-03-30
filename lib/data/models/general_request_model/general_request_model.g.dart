// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralRequestModel _$GeneralRequestModelFromJson(Map<String, dynamic> json) =>
    GeneralRequestModel(
      requestType: json['requestType'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$GeneralRequestModelToJson(
        GeneralRequestModel instance) =>
    <String, dynamic>{
      'requestType': instance.requestType,
      'note': instance.note,
    };
