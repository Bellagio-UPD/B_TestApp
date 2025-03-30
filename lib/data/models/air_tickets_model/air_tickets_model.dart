import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/air_tickets_entity/air_tickets_entity.dart';

part 'air_tickets_model.g.dart';

@JsonSerializable()
class AirTicketModel extends AirTicketEntity {
  const AirTicketModel({
    super.AirTicketBookingId,
    super.FlightNumber,
    super.TicketNumber,
    super.PassengerName,
    super.DepartureDate,
    super.ArrivalDate,
    super.DepartureAirport,
    super.ArrivalAirport,
    super.Airline,
    super.SeatNumber,
    super.Terminal,
    super.Gate,
    super.Price,
    super.Class,
    super.TicketId,
    super.Ticket,
    super.BookingId,
    super.TripType,
    super.CustomerId,
    super.deleted,
  });

  factory AirTicketModel.fromJson(Map<String, dynamic> json) =>
      _$AirTicketModelFromJson(json);

  Map<String, dynamic> toJson() => _$AirTicketModelToJson(this);
}
