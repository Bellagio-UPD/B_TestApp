import '../details_entity.dart';

class VehicleBookingEntity extends DetailsEntity {
  final String vehicleType;
  final DateTime? pickupDateTime;
  final String pickupAddress;
  final String dropOffLocation;
  final String? additionalRequest;

  const VehicleBookingEntity({
    required this.vehicleType,
    this.pickupDateTime,
    required this.pickupAddress,
    required this.dropOffLocation,
    this.additionalRequest,
  });

  @override
  List<Object?> get props => [
    vehicleType,
    pickupDateTime,
    pickupAddress,
    dropOffLocation,
    additionalRequest,
  ];

  @override
  Map<String, dynamic> toJson() {
    return {
      'vehicleType': vehicleType,
      'pickupDateTime': pickupDateTime?.toIso8601String(),
      'pickupAddress': pickupAddress,
      'dropOffLocation': dropOffLocation,
      'additionalRequest': additionalRequest,
    };
  }
}
