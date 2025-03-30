import '../details_entity.dart';

class HotelReservationsEntity extends DetailsEntity {
  final String? name;
  final String? hotelName;
  final String? city;
  final String? roomType;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final String? mealPreference;
  final String? additionalRequest;

  const HotelReservationsEntity({
    this.name,
    this.hotelName,
    this.city,
    this.roomType,
    this.checkInDate,
    this.checkOutDate,
    this.mealPreference,
    this.additionalRequest,
  });

  @override
  List<Object?> get props => [
    name,
    hotelName,
    city,
    roomType,
    checkInDate,
    checkOutDate,
    mealPreference,
    additionalRequest,
  ];

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hotelName': hotelName,
      'city': city,
      'roomType': roomType,
      'checkInDate': checkInDate?.toIso8601String(),
      'checkOutDate': checkOutDate?.toIso8601String(),
      'mealPreference': mealPreference,
      'additionalRequest': additionalRequest,
    };
  }
}
