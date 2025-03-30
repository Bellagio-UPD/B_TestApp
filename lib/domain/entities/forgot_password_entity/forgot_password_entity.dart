import 'package:equatable/equatable.dart';

class ForgotPasswordEntity extends Equatable {
  final String? mobileNumber;
  final String? newPassword;
  final String? confirmNewPassword;

  const ForgotPasswordEntity({
    this.mobileNumber,
    this.newPassword,
    this.confirmNewPassword,
  });

  @override
  List<Object?> get props => [
        mobileNumber,
        newPassword,
        confirmNewPassword,
      ];
}
