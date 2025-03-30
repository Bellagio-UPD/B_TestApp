import 'package:bellagio_mobile_user/domain/entities/gifts_entity/gifts_entity.dart';
import 'package:bellagio_mobile_user/domain/entities/gifts_entity/options_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'options_model.g.dart';

@JsonSerializable()
class OptionsModel extends OptionsEntity {
  OptionsModel({super.Name, super.Location, super.Validity});

  factory OptionsModel.fromJson(Map<String, dynamic> json) =>
      _$OptionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$OptionsModelToJson(this);
}
