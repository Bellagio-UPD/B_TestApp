import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/deposits_entity/deposits_entity.dart';

part 'deposits_model.g.dart';

@JsonSerializable()
class DepositModel extends DepositEntity {
  const DepositModel({
    super.DepositId,
    super.Amount,
    super.Description,
    super.Date,
    super.DepositType,
    super.Currency,
    super.ProofOfTransaction,
    super.ProofOfConfirmation,
    super.CustomerId,
    super.Status,
    super.Deleted,
  });

  factory DepositModel.fromJson(Map<String, dynamic> json) =>
      _$DepositModelFromJson(json);

  Map<String, dynamic> toJson() => _$DepositModelToJson(this);
}
