import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/airports_entity/airports_entity.dart';

part 'airports_model.g.dart';

@JsonSerializable()
class AirportModel extends AirportEntity {
  const AirportModel({
    super.countryCode,
    super.iata,
    super.airport,
    super.isDisabled,
  });

  factory AirportModel.fromJson(Map<String, dynamic> json) =>
      _$AirportModelFromJson(json);

  Map<String, dynamic> toJson() => _$AirportModelToJson(this);
}
