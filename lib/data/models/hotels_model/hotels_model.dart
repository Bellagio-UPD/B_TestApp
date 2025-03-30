import 'package:bellagio_mobile_user/domain/entities/hotels_entity/hotels_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hotels_model.g.dart';

@JsonSerializable()
class HotelsModel extends HotelsEntity {
  const HotelsModel({
    super.HotelId,
    super.Name,
    super.Location,
    super.Rating,
    super.Price,
    super.Photo,
    super.Deleted,
  });

  factory HotelsModel.fromJson(Map<String, dynamic> json) =>
      _$HotelsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelsModelToJson(this);
}
