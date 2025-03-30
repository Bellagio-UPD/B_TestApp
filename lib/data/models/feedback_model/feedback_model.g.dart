// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackModel _$FeedbackModelFromJson(Map<String, dynamic> json) =>
    FeedbackModel(
      FeedbackId: json['FeedbackId'] as String?,
      Content: json['Content'] as String?,
      TableNumber: json['TableNumber'] as String?,
      GamingServiceRating: (json['GamingServiceRating'] as num?)?.toInt(),
      FrontOfficeRating: (json['FrontOfficeRating'] as num?)?.toInt(),
      FandBServiceRating: (json['FandBServiceRating'] as num?)?.toInt(),
      TableNStaffRating: (json['TableNStaffRating'] as num?)?.toInt(),
      CustomerId: json['CustomerId'] as String?,
      deleted: json['deleted'] as bool?,
    );

Map<String, dynamic> _$FeedbackModelToJson(FeedbackModel instance) =>
    <String, dynamic>{
      'FeedbackId': instance.FeedbackId,
      'Content': instance.Content,
      'TableNumber': instance.TableNumber,
      'GamingServiceRating': instance.GamingServiceRating,
      'FrontOfficeRating': instance.FrontOfficeRating,
      'FandBServiceRating': instance.FandBServiceRating,
      'TableNStaffRating': instance.TableNStaffRating,
      'CustomerId': instance.CustomerId,
      'deleted': instance.deleted,
    };
