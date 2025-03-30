import 'package:bellagio_mobile_user/domain/entities/request_entity/details_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hotel_reservation_model.g.dart';

@JsonSerializable()
class HotelReservations extends DetailsEntity {
  final String? GuestName;
  final String? CheckInDate;
  final String? CheckOutDate;
  final String? RoomType;
  final String? Email;
  final String? HotelName;
  final String? HotelId;

  const HotelReservations({
    this.GuestName,
    this.CheckInDate,
    this.CheckOutDate,
    this.RoomType,
    this.Email,
    this.HotelName,
    this.HotelId,
  });

  factory HotelReservations.fromJson(Map<String, dynamic> json) =>
      _$HotelReservationsFromJson(json);

  Map<String, dynamic> toJson() => _$HotelReservationsToJson(this);
}
