import 'package:equatable/equatable.dart';

class GiftsEntity extends Equatable {
  final String? CustomerGiftId;
  final int? Quantity;
  final String? Status;
  final String? Category;
  final String? ClaimCode;
  final String? Description;
  final String? Location;
  final String? Validity;
  final String? Title;
  final String? CustomerId;
  final bool? deleted;

  const GiftsEntity({
    this.CustomerGiftId,
    this.Quantity,
    this.Status,
    this.Category,
    this.ClaimCode,
    this.Description,
    this.Location,
    this.Validity,
    this.Title,
    this.CustomerId,
    this.deleted,
  });

  @override
  List<Object?> get props {
    return [
      CustomerGiftId,
      Quantity,
      Status,
      Category,
      ClaimCode,
      Description,
      Location,
      Validity,
      Title,
      CustomerId,
      deleted
    ];
  }
}
