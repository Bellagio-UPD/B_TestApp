import 'package:bellagio_mobile_user/domain/entities/request_entity/details_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'air_ticket_booking_model.g.dart';

@JsonSerializable()
class AirTicketBookingModel extends DetailsEntity {
  final String? DepartureDate;
  final String? ArrivalDate;
  final String? DepartureAirport;
  final String? ArrivalAirport;
  final String? Class;
  final String? TripType;

  const AirTicketBookingModel({
    me,
    this.DepartureDate,
    this.ArrivalDate,
    this.DepartureAirport,
    this.ArrivalAirport,
    this.Class,
    this.TripType,
  });

  factory AirTicketBookingModel.fromJson(Map<String, dynamic> json) =>
      _$AirTicketBookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$AirTicketBookingModelToJson(this);
}
