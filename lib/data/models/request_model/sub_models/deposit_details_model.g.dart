// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepositDetails _$DepositDetailsFromJson(Map<String, dynamic> json) =>
    DepositDetails(
      Document: json['Document'] as String?,
      Message: json['Message'] as String?,
      RequestDate: json['RequestDate'] as String?,
      Location: json['Location'] as String?,
      PackageId: json['PackageId'] as String?,
      PackageName: json['PackageName'] as String?,
    );

Map<String, dynamic> _$DepositDetailsToJson(DepositDetails instance) =>
    <String, dynamic>{
      'Document': instance.Document,
      'Message': instance.Message,
      'RequestDate': instance.RequestDate,
      'Location': instance.Location,
      'PackageId': instance.PackageId,
      'PackageName': instance.PackageName,
    };
