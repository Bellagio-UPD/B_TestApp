import 'package:equatable/equatable.dart';

class LoyaltyCardsEntity extends Equatable {
  final String? LoyaltyProgramId;
  final String? Name;
  final String? Description;
  final List<String>? Cards;
  final bool? IsActive;
  final String? TierLevel;
  final int? MinimumRewardPoints;
  final int? TopLine;
  final bool? Deleted;

  const LoyaltyCardsEntity({
     this.LoyaltyProgramId,
     this.Name,
     this.Description,
     this.Cards,
     this.IsActive,
     this.TierLevel,
     this.MinimumRewardPoints,
     this.TopLine,
     this.Deleted,
  });

  @override
  List<Object?> get props => [
        LoyaltyProgramId,
        Name,
        Description,
        Cards,
        IsActive,
        TierLevel,
        MinimumRewardPoints,
        TopLine,
        Deleted,
      ];
}
