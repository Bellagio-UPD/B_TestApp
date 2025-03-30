import 'package:equatable/equatable.dart';

class SignUpEntity extends Equatable {
  final String? CustomerId;
  final String? FirstName;
  final String? LastName;
  final String? Email;
  final String? ProfileImage;
  final String? Phone;
  final String? Password;
  final String? FBEmail;
  final String? CountryCode;
  final String? BellagioId;
  final String? Country;

  const SignUpEntity(
      {this.CustomerId,
      this.FirstName,
      this.LastName,
      this.Email,
      this.ProfileImage,
      this.Phone,
      this.Password,
      this.FBEmail,
      this.CountryCode,
      this.BellagioId,
      this.Country});

  @override
  List<Object?> get props {
    return [
      CustomerId,
      FirstName,
      LastName,
      Email,
      ProfileImage,
      Phone,
      Password,
      FBEmail,
      CountryCode,
      BellagioId,
      Country
    ];
  }
}
