import 'package:bellagio_mobile_user/domain/entities/loyalty_cards_entity/loyalty_cards_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'loyalty_cards_model.g.dart';

@JsonSerializable()
class LoyaltyCardsModel extends LoyaltyCardsEntity {
  const LoyaltyCardsModel({
    super.LoyaltyProgramId,
    super.Name,
    super.Description,
    super.IsActive,
    super.TierLevel,
    super.Cards,
    super.TopLine,
    super.Deleted,
    super.MinimumRewardPoints,
  });

  factory LoyaltyCardsModel.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyCardsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoyaltyCardsModelToJson(this);
}
