part of 'otp_cubit.dart';

abstract class OtpState extends Equatable {
  final String? userId;
  final int? otp;
  final String? mobileNumber;
  final DioException? error;

  OtpState({this.mobileNumber, this.userId, this.otp, this.error});

  @override
  List<Object?> get props => [userId, otp, mobileNumber, error];
}

class validateOtpState extends OtpState {
  validateOtpState({String? mobileNumber, int? otp})
      : super(mobileNumber: mobileNumber, otp: otp);
}

class validateOtpErrorState extends OtpState {
  validateOtpErrorState({String? mobileNumber, int? otp, DioException? error})
      : super(mobileNumber: mobileNumber, otp: otp, error: error);
}

class sendOtpState extends OtpState {
  sendOtpState({String? userId, String? mobileNumber})
      : super(userId: userId, mobileNumber: mobileNumber);
}

class sendOtpErrorState extends OtpState {
  sendOtpErrorState({String? userId, String? mobileNumber, DioException? error})
      : super(userId: userId, mobileNumber: mobileNumber, error: error);
}

class resendOtpState extends OtpState {
  resendOtpState({String? mobileNumber})
      : super(mobileNumber: mobileNumber);
}

class resendOtpErrorState extends OtpState {
  resendOtpErrorState({String? mobileNumber, DioException? error})
      : super(mobileNumber: mobileNumber, error: error);
}


