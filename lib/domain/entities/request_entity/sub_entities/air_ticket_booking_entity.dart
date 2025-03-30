
import '../details_entity.dart';

class AirTicketBookingEntity extends DetailsEntity {
  final String? airline;
  final String departureCity;
  final String arrivalCity;
  final String departureDate;
  final String? returnDate;
  final bool isReturnNeeded;
  final String? seatPreference;
  final String? mealPreference;
  final String? luggageDetails;
  final String? additionalRequest;

  const AirTicketBookingEntity({
    required this.airline,
    required this.departureCity,
    required this.arrivalCity,
    required this.departureDate,
    this.returnDate,
    required this.isReturnNeeded,
    this.seatPreference,
    this.mealPreference,
    this.luggageDetails,
    this.additionalRequest,
  });

  @override
  List<Object?> get props => [
    airline,
    departureCity,
    arrivalCity,
    departureDate,
    returnDate,
    isReturnNeeded,
    seatPreference,
    mealPreference,
    luggageDetails,
    additionalRequest,
  ];

  @override
  Map<String, dynamic> toJson() {
    return {
      'airline': airline,
      'departureCity': departureCity,
      'arrivalCity': arrivalCity,
      'departureDate': departureDate,
      'returnDate': returnDate,
      'isReturnNeeded': isReturnNeeded,
      'seatPreference': seatPreference,
      'mealPreference': mealPreference,
      'luggageDetails':luggageDetails,
      'additionalRequest': additionalRequest,
    };
  }
}