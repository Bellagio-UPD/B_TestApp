// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code_return_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QrCodeReturnModel _$QrCodeReturnModelFromJson(Map<String, dynamic> json) =>
    QrCodeReturnModel(
      BellagioId: json['BellagioId'] as String?,
      Name: json['Name'] as String?,
      VoucherAmount: (json['VoucherAmount'] as num?)?.toInt(),
      LoyaltyProgramId: json['LoyaltyProgramId'] as String?,
      GiftType: json['GiftType'] as String?,
    );

Map<String, dynamic> _$QrCodeReturnModelToJson(QrCodeReturnModel instance) =>
    <String, dynamic>{
      'BellagioId': instance.BellagioId,
      'Name': instance.Name,
      'VoucherAmount': instance.VoucherAmount,
      'LoyaltyProgramId': instance.LoyaltyProgramId,
      'GiftType': instance.GiftType,
    };
