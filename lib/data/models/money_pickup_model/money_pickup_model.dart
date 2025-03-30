import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/money_pickup_entity/money_pickup_entity.dart';

part 'money_pickup_model.g.dart';

@JsonSerializable()
class MoneyPickupModel extends MoneyPickupEntity {
  const MoneyPickupModel({super.address, super.time, super.date, super.note});

  factory MoneyPickupModel.fromJson(Map<String, dynamic> json) =>
      _$MoneyPickupModelFromJson(json);

  Map<String, dynamic> toJson() => _$MoneyPickupModelToJson(this);
}
