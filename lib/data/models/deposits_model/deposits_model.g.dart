// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepositModel _$DepositModelFromJson(Map<String, dynamic> json) => DepositModel(
      DepositId: json['DepositId'] as String?,
      Amount: (json['Amount'] as num?)?.toDouble(),
      Description: json['Description'] as String?,
      Date: json['Date'] as String?,
      DepositType: json['DepositType'] as String?,
      Currency: json['Currency'] as String?,
      ProofOfTransaction: (json['ProofOfTransaction'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      ProofOfConfirmation: json['ProofOfConfirmation'] as String?,
      CustomerId: json['CustomerId'] as String?,
      Status: json['Status'] as String?,
      Deleted: json['Deleted'] as bool?,
    );

Map<String, dynamic> _$DepositModelToJson(DepositModel instance) =>
    <String, dynamic>{
      'DepositId': instance.DepositId,
      'Amount': instance.Amount,
      'Description': instance.Description,
      'Date': instance.Date,
      'DepositType': instance.DepositType,
      'Currency': instance.Currency,
      'ProofOfTransaction': instance.ProofOfTransaction,
      'ProofOfConfirmation': instance.ProofOfConfirmation,
      'CustomerId': instance.CustomerId,
      'Status': instance.Status,
      'Deleted': instance.Deleted,
    };
