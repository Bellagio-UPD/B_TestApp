import 'package:equatable/equatable.dart';

class AirTicketEntity extends Equatable {
  final String? AirTicketBookingId;
  final String? FlightNumber;
  final String? TicketNumber;
  final String? PassengerName;
  final String? DepartureDate;
  final String? ArrivalDate;
  final String? DepartureAirport;
  final String? ArrivalAirport;
  final String? Airline;
  final String? SeatNumber;
  final String? Terminal;
  final String? Gate;
  final double? Price;
  final String? Class;
  final String? TicketId;
  final List<String>? Ticket;
  final String? BookingId;
  final String? TripType;
  final String? CustomerId;
  final bool? deleted;

  const AirTicketEntity({
    this.AirTicketBookingId,
    this.FlightNumber,
    this.TicketNumber,
    this.PassengerName,
    this.DepartureDate,
    this.ArrivalDate,
    this.DepartureAirport,
    this.ArrivalAirport,
    this.Airline,
    this.SeatNumber,
    this.Terminal,
    this.Gate,
    this.Price,
    this.Class,
    this.TicketId,
    this.Ticket,
    this.BookingId,
    this.TripType,
    this.CustomerId,
    this.deleted,
  });

  @override
  List<Object?> get props {
    return [
      AirTicketBookingId,
      FlightNumber,
      TicketNumber,
      PassengerName,
      DepartureDate,
      ArrivalDate,
      DepartureAirport,
      ArrivalAirport,
      Airline,
      SeatNumber,
      Terminal,
      Gate,
      Price,
      Class,
      TicketId,
      Ticket,
      BookingId,
      TripType,
      CustomerId,
      deleted,
    ];
  }
}
