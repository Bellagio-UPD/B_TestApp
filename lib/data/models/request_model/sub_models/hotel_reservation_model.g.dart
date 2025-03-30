// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_reservation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelReservations _$HotelReservationsFromJson(Map<String, dynamic> json) =>
    HotelReservations(
      GuestName: json['GuestName'] as String?,
      CheckInDate: json['CheckInDate'] as String?,
      CheckOutDate: json['CheckOutDate'] as String?,
      RoomType: json['RoomType'] as String?,
      Email: json['Email'] as String?,
      HotelName: json['HotelName'] as String?,
      HotelId: json['HotelId'] as String?,
    );

Map<String, dynamic> _$HotelReservationsToJson(HotelReservations instance) =>
    <String, dynamic>{
      'GuestName': instance.GuestName,
      'CheckInDate': instance.CheckInDate,
      'CheckOutDate': instance.CheckOutDate,
      'RoomType': instance.RoomType,
      'Email': instance.Email,
      'HotelName': instance.HotelName,
      'HotelId': instance.HotelId,
    };
