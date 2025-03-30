import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/login_user_entity/login_user_entity.dart';

part 'login_user_model.g.dart';

@JsonSerializable()
class LoginUserModel extends LoginUserEntity {
  const LoginUserModel({
super.EmailOrPhone,
  super.Password,
  super.GrantType
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) =>
      _$LoginUserModelFromJson(json); 

  Map<String, dynamic> toJson() => _$LoginUserModelToJson(this); 
}
