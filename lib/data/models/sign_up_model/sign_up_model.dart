import 'package:bellagio_mobile_user/domain/entities/sign_up_entity/sign_up_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_model.g.dart';

@JsonSerializable()
class SignUpModel extends SignUpEntity {
  const SignUpModel({
  super.CustomerId,
  super.FirstName,
  super.LastName,
  super.Email,
  super.ProfileImage,
  super.Phone,
  super.Password,
  super.FBEmail,
  super.CountryCode,
  super.BellagioId,
  super.Country
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json); 

  Map<String, dynamic> toJson() => _$SignUpModelToJson(this); 
}
