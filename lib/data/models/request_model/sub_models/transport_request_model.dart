import 'package:bellagio_mobile_user/domain/entities/request_entity/details_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transport_request_model.g.dart';

@JsonSerializable()
class TransportRequestModel extends DetailsEntity {
  final String? PickupLocation;
  final String? DropoffLocation;
  final String? PickupTime;
  final String? VehicleType;
  final String? CustomerId;
  final String? CustomerName;
  final String? TripType;

  const TransportRequestModel({
    this.PickupLocation,
    this.DropoffLocation,
    this.PickupTime,
    this.VehicleType,
    this.CustomerId,
    this.CustomerName,
    this.TripType
  });

  factory TransportRequestModel.fromJson(Map<String, dynamic> json) =>
      _$TransportRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransportRequestModelToJson(this);
}
