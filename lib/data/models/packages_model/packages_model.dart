import 'package:bellagio_mobile_user/domain/entities/packages_entity/packages_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'packages_model.g.dart';

@JsonSerializable()
class PackagesModel extends PackagesEntity {
  const PackagesModel({
    super.PackageId,
    super.Name,
    super.Description,
    super.Price,
    super.Currency,
    super.StartDate,
    super.IsActive,
    super.Deleted,
  });

  factory PackagesModel.fromJson(Map<String, dynamic> json) =>
      _$PackagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$PackagesModelToJson(this);
}
