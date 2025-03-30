import 'package:equatable/equatable.dart';

class UserInfoEntity extends Equatable {
  final String? CustomerId;
  final String? FirstName;
  final String? LastName;
  final String? Email;
  final String? ProfileImage;
  final String? CoverImage;
  final String? Country;
  final String? Phone;
  final String? Address;
  final int? Age;
  final String? Gender;
  final String? ManagerId;
  final String? LoyaltyProgramId;
  final String? CustomerPackageId;
  final String? BellagioId;
  final int? Points;
  final bool? IsValidated;
  final double? OTPPoints;
  final String? RegistrationQR;
  final bool? Deleted;
  final String? QId;

  const UserInfoEntity({
    this.CustomerId,
    this.FirstName,
    this.LastName,
    this.Email,
    this.ProfileImage,
    this.CoverImage,
    this.Country,
    this.Phone,
    this.Address,
    this.Age,
    this.Gender,
    this.ManagerId,
    this.LoyaltyProgramId,
    this.CustomerPackageId,
    this.BellagioId,
    this.Points,
    this.IsValidated,
    this.OTPPoints,
    this.RegistrationQR,
    this.Deleted,
    this.QId
  });

  @override
  List<Object?> get props {
    return [
      CustomerId,
      FirstName,
      LastName,
      Email,
      ProfileImage,
      CoverImage,
      Country,
      Phone,
      Address,
      Age,
      Gender,
      ManagerId,
      LoyaltyProgramId,
      CustomerPackageId,
      BellagioId,
      Points,
      IsValidated,
      OTPPoints,
      RegistrationQR,
      Deleted,
      QId
    ];
  }
}
