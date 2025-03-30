import 'package:bellagio_mobile_user/domain/entities/offers_entity/offers_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'offers_model.g.dart';

@JsonSerializable()
class OffersModel extends OffersEntity {
  const OffersModel({
    super.OfferId,
    super.Title,
    super.Description,
    super.EndDate,
    super.ClaimCode,
    super.MerchantName,
    super.Offerings,
    super.OfferType,
    super.LoyaltyProgramId,
    super.Deleted,
  });

  factory OffersModel.fromJson(Map<String, dynamic> json) =>
      _$OffersModelFromJson(json);

  Map<String, dynamic> toJson() => _$OffersModelToJson(this);
}
