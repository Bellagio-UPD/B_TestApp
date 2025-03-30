import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/fcm_toekn/fcm_token_register_entity.dart';

part 'fcm_token_model.g.dart';

@JsonSerializable()
class FCMTokenRegisterModel extends FCMTokenRegisterEntity {
  const FCMTokenRegisterModel({
    super.Token,
    super.CustomerID,
  });

  factory FCMTokenRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$FCMTokenRegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$FCMTokenRegisterModelToJson(this);
}
