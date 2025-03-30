import 'package:bellagio_mobile_user/domain/entities/gifts_entity/gifts_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gifts_model.g.dart';

@JsonSerializable()
class GiftsModel extends GiftsEntity {
  const GiftsModel({
    super.CustomerGiftId,
    super.Quantity,
    super.Status,
    super.Category,
    super.ClaimCode,
    super.Description,
    super.Location,
    super.Title,
    super.Validity,
    super.CustomerId,
    super.deleted,
  });

  factory GiftsModel.fromJson(Map<String, dynamic> json) =>
      _$GiftsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GiftsModelToJson(this);
}
