import 'package:equatable/equatable.dart';

class HotelsEntity extends Equatable {
  final String? HotelId;
  final String? Name;
  final String? Location;
  final double? Rating;
  final double? Price;
  final List<String>? Photo;
  final bool? Deleted;

  const HotelsEntity({
    this.HotelId,
    this.Name,
    this.Location,
    this.Rating,
    this.Price,
    this.Photo,
    this.Deleted,
  });

  @override
  List<Object?> get props {
    return [
      HotelId,
      Name,
      Location,
      Rating,
      Price,
      Photo,
      Deleted,
    ];
  }
}
