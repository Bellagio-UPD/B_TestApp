// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawalModel _$WithdrawalModelFromJson(Map<String, dynamic> json) =>
    WithdrawalModel(
      WithdrawalsId: json['WithdrawalsId'] as String?,
      Amount: (json['Amount'] as num?)?.toDouble(),
      Date: json['Date'] as String?,
      Status: json['Status'] as String?,
      Currency: json['Currency'] as String?,
      ProofOfTransaction: (json['ProofOfTransaction'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      CustomerId: json['CustomerId'] as String?,
      Deleted: json['Deleted'] as bool?,
    );

Map<String, dynamic> _$WithdrawalModelToJson(WithdrawalModel instance) =>
    <String, dynamic>{
      'WithdrawalsId': instance.WithdrawalsId,
      'Amount': instance.Amount,
      'Date': instance.Date,
      'Status': instance.Status,
      'Currency': instance.Currency,
      'ProofOfTransaction': instance.ProofOfTransaction,
      'CustomerId': instance.CustomerId,
      'Deleted': instance.Deleted,
    };
