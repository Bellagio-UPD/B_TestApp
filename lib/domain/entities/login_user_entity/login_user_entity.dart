import 'package:equatable/equatable.dart';

class LoginUserEntity extends Equatable {
  final String? EmailOrPhone;
  final String? Password;
  final String? GrantType;

  const LoginUserEntity({this.EmailOrPhone, this.Password, this.GrantType});

  @override
  List<Object?> get props {
    return [EmailOrPhone, Password, GrantType];
  }
}
