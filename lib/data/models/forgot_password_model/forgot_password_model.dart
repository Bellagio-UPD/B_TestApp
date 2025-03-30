import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/forgot_password_entity/forgot_password_entity.dart';


part 'forgot_password_model.g.dart';

@JsonSerializable()
class ForgotPasswordModel extends ForgotPasswordEntity {
  const ForgotPasswordModel({
    super.mobileNumber,
    super.newPassword,
    super.confirmNewPassword,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordModelToJson(this);
}
