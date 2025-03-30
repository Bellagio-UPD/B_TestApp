// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'air_ticket_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirTicketBookingModel _$AirTicketBookingModelFromJson(
        Map<String, dynamic> json) =>
    AirTicketBookingModel(
      DepartureDate: json['DepartureDate'] as String?,
      ArrivalDate: json['ArrivalDate'] as String?,
      DepartureAirport: json['DepartureAirport'] as String?,
      ArrivalAirport: json['ArrivalAirport'] as String?,
      Class: json['Class'] as String?,
      TripType: json['TripType'] as String?,
    );

Map<String, dynamic> _$AirTicketBookingModelToJson(
        AirTicketBookingModel instance) =>
    <String, dynamic>{
      'DepartureDate': instance.DepartureDate,
      'ArrivalDate': instance.ArrivalDate,
      'DepartureAirport': instance.DepartureAirport,
      'ArrivalAirport': instance.ArrivalAirport,
      'Class': instance.Class,
      'TripType': instance.TripType,
    };
