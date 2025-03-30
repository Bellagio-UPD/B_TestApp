import 'package:bellagio_mobile_user/domain/entities/gifts_entity/options_entity.dart';
import 'package:equatable/equatable.dart';

class QrCodeReturnEntity extends Equatable {
  final String? BellagioId;
  final String? Name;
  final int? VoucherAmount;
  final String? LoyaltyProgramId;
  final String? GiftType;

  QrCodeReturnEntity({this.BellagioId, this.Name, this.VoucherAmount,this.LoyaltyProgramId,this.GiftType});

  @override
  List<Object?> get props {
    return [BellagioId, Name, VoucherAmount, LoyaltyProgramId, GiftType];
  }
}
