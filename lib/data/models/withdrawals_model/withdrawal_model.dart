import 'package:bellagio_mobile_user/domain/entities/withdrawals_entity/withdrawals_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'withdrawal_model.g.dart';

@JsonSerializable()
class WithdrawalModel extends WithdrawalEntity {
  const WithdrawalModel({
    super.WithdrawalsId,
    super.Amount,
    super.Date,
    super.Status,
    super.Currency,
    super.ProofOfTransaction,
    super.CustomerId,
    super.Deleted,
  });

  factory WithdrawalModel.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalModelFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawalModelToJson(this);
}
