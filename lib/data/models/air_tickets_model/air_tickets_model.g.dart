// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'air_tickets_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirTicketModel _$AirTicketModelFromJson(Map<String, dynamic> json) =>
    AirTicketModel(
      AirTicketBookingId: json['AirTicketBookingId'] as String?,
      FlightNumber: json['FlightNumber'] as String?,
      TicketNumber: json['TicketNumber'] as String?,
      PassengerName: json['PassengerName'] as String?,
      DepartureDate: json['DepartureDate'] as String?,
      ArrivalDate: json['ArrivalDate'] as String?,
      DepartureAirport: json['DepartureAirport'] as String?,
      ArrivalAirport: json['ArrivalAirport'] as String?,
      Airline: json['Airline'] as String?,
      SeatNumber: json['SeatNumber'] as String?,
      Terminal: json['Terminal'] as String?,
      Gate: json['Gate'] as String?,
      Price: (json['Price'] as num?)?.toDouble(),
      Class: json['Class'] as String?,
      TicketId: json['TicketId'] as String?,
      Ticket:
          (json['Ticket'] as List<dynamic>?)?.map((e) => e as String).toList(),
      BookingId: json['BookingId'] as String?,
      TripType: json['TripType'] as String?,
      CustomerId: json['CustomerId'] as String?,
      deleted: json['deleted'] as bool?,
    );

Map<String, dynamic> _$AirTicketModelToJson(AirTicketModel instance) =>
    <String, dynamic>{
      'AirTicketBookingId': instance.AirTicketBookingId,
      'FlightNumber': instance.FlightNumber,
      'TicketNumber': instance.TicketNumber,
      'PassengerName': instance.PassengerName,
      'DepartureDate': instance.DepartureDate,
      'ArrivalDate': instance.ArrivalDate,
      'DepartureAirport': instance.DepartureAirport,
      'ArrivalAirport': instance.ArrivalAirport,
      'Airline': instance.Airline,
      'SeatNumber': instance.SeatNumber,
      'Terminal': instance.Terminal,
      'Gate': instance.Gate,
      'Price': instance.Price,
      'Class': instance.Class,
      'TicketId': instance.TicketId,
      'Ticket': instance.Ticket,
      'BookingId': instance.BookingId,
      'TripType': instance.TripType,
      'CustomerId': instance.CustomerId,
      'deleted': instance.deleted,
    };
