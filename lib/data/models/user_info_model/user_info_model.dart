import 'package:bellagio_mobile_user/domain/entities/user_info_entity/user_info_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoModel extends UserInfoEntity {
  const UserInfoModel({
    super.CustomerId,
    super.FirstName,
    super.LastName,
    super.Email,
    super.ProfileImage,
    super.CoverImage,
    super.Country,
    super.Phone,
    super.Address,
    super.Age,
    super.Gender,
    super.ManagerId,
    super.LoyaltyProgramId,
    super.CustomerPackageId,
    super.BellagioId,
    super.Points,
    super.IsValidated,
    super.OTPPoints,
    super.RegistrationQR,
    super.Deleted,
    super.QId
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}
