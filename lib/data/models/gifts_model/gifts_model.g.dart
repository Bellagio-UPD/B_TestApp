// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gifts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiftsModel _$GiftsModelFromJson(Map<String, dynamic> json) => GiftsModel(
      CustomerGiftId: json['CustomerGiftId'] as String?,
      Quantity: (json['Quantity'] as num?)?.toInt(),
      Status: json['Status'] as String?,
      Category: json['Category'] as String?,
      ClaimCode: json['ClaimCode'] as String?,
      Description: json['Description'] as String?,
      Location: json['Location'] as String?,
      Title: json['Title'] as String?,
      Validity: json['Validity'] as String?,
      CustomerId: json['CustomerId'] as String?,
      deleted: json['deleted'] as bool?,
    );

Map<String, dynamic> _$GiftsModelToJson(GiftsModel instance) =>
    <String, dynamic>{
      'CustomerGiftId': instance.CustomerGiftId,
      'Quantity': instance.Quantity,
      'Status': instance.Status,
      'Category': instance.Category,
      'ClaimCode': instance.ClaimCode,
      'Description': instance.Description,
      'Location': instance.Location,
      'Validity': instance.Validity,
      'Title': instance.Title,
      'CustomerId': instance.CustomerId,
      'deleted': instance.deleted,
    };
