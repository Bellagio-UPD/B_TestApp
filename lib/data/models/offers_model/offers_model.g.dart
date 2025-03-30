// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffersModel _$OffersModelFromJson(Map<String, dynamic> json) => OffersModel(
      OfferId: json['OfferId'] as String?,
      Title: json['Title'] as String?,
      Description: json['Description'] as String?,
      EndDate: json['EndDate'] as String?,
      ClaimCode: json['ClaimCode'] as String?,
      MerchantName: json['MerchantName'] as String?,
      Offerings: (json['Offerings'] as num?)?.toInt(),
      OfferType: json['OfferType'] as String?,
      LoyaltyProgramId: json['LoyaltyProgramId'] as String?,
      Deleted: json['Deleted'] as bool?,
    );

Map<String, dynamic> _$OffersModelToJson(OffersModel instance) =>
    <String, dynamic>{
      'OfferId': instance.OfferId,
      'Title': instance.Title,
      'Description': instance.Description,
      'EndDate': instance.EndDate,
      'ClaimCode': instance.ClaimCode,
      'MerchantName': instance.MerchantName,
      'Offerings': instance.Offerings,
      'OfferType': instance.OfferType,
      'LoyaltyProgramId': instance.LoyaltyProgramId,
      'Deleted': instance.Deleted,
    };
