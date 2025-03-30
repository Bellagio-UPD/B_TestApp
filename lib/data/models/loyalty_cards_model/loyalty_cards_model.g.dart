// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyalty_cards_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoyaltyCardsModel _$LoyaltyCardsModelFromJson(Map<String, dynamic> json) =>
    LoyaltyCardsModel(
      LoyaltyProgramId: json['LoyaltyProgramId'] as String?,
      Name: json['Name'] as String?,
      Description: json['Description'] as String?,
      IsActive: json['IsActive'] as bool?,
      TierLevel: json['TierLevel'] as String?,
      Cards:
          (json['Cards'] as List<dynamic>?)?.map((e) => e as String).toList(),
      TopLine: (json['TopLine'] as num?)?.toInt(),
      Deleted: json['Deleted'] as bool?,
      MinimumRewardPoints: (json['MinimumRewardPoints'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LoyaltyCardsModelToJson(LoyaltyCardsModel instance) =>
    <String, dynamic>{
      'LoyaltyProgramId': instance.LoyaltyProgramId,
      'Name': instance.Name,
      'Description': instance.Description,
      'Cards': instance.Cards,
      'IsActive': instance.IsActive,
      'TierLevel': instance.TierLevel,
      'MinimumRewardPoints': instance.MinimumRewardPoints,
      'TopLine': instance.TopLine,
      'Deleted': instance.Deleted,
    };
