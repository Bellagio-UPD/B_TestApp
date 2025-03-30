import 'package:equatable/equatable.dart';

class OffersEntity extends Equatable {
  final String? OfferId;
  final String? Title;
  final String? Description;
  final String? EndDate;
  final String? ClaimCode;
  final String? MerchantName;
  final int? Offerings;
  final String? OfferType;
  final String? LoyaltyProgramId;
  final bool? Deleted;

  const OffersEntity({
    this.OfferId,
    this.Title,
    this.Description,
    this.EndDate,
    this.ClaimCode,
    this.MerchantName,
    this.Offerings,
    this.OfferType,
    this.LoyaltyProgramId,
    this.Deleted,
  });

  @override
  List<Object?> get props {
    return [
      OfferId,
      Title,
      Description,
      EndDate,
      ClaimCode,
      MerchantName,
      Offerings,
      OfferType,
      LoyaltyProgramId,
      Deleted,
    ];
  }
}
