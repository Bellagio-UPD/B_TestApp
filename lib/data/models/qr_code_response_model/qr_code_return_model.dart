import 'package:bellagio_mobile_user/domain/entities/gifts_entity/qr_code_return_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'qr_code_return_model.g.dart';

@JsonSerializable()
class QrCodeReturnModel extends QrCodeReturnEntity {
  QrCodeReturnModel(
      {super.BellagioId,
      super.Name,
      super.VoucherAmount,
      super.LoyaltyProgramId,
      super.GiftType});

  factory QrCodeReturnModel.fromJson(Map<String, dynamic> json) =>
      _$QrCodeReturnModelFromJson(json);

  Map<String, dynamic> toJson() => _$QrCodeReturnModelToJson(this);
}
