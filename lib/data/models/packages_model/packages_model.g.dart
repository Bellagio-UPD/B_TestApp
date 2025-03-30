// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packages_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackagesModel _$PackagesModelFromJson(Map<String, dynamic> json) =>
    PackagesModel(
      PackageId: json['PackageId'] as String?,
      Name: json['Name'] as String?,
      Description: json['Description'] as String?,
      Price: (json['Price'] as num?)?.toDouble(),
      Currency: json['Currency'] as String?,
      StartDate: json['StartDate'] as String?,
      IsActive: json['IsActive'] as bool?,
      Deleted: json['Deleted'] as bool?,
    );

Map<String, dynamic> _$PackagesModelToJson(PackagesModel instance) =>
    <String, dynamic>{
      'PackageId': instance.PackageId,
      'Name': instance.Name,
      'Description': instance.Description,
      'Price': instance.Price,
      'Currency': instance.Currency,
      'StartDate': instance.StartDate,
      'IsActive': instance.IsActive,
      'Deleted': instance.Deleted,
    };
