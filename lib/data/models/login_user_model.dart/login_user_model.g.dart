// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUserModel _$LoginUserModelFromJson(Map<String, dynamic> json) =>
    LoginUserModel(
      EmailOrPhone: json['EmailOrPhone'] as String?,
      Password: json['Password'] as String?,
      GrantType: json['GrantType'] as String?,
    );

Map<String, dynamic> _$LoginUserModelToJson(LoginUserModel instance) =>
    <String, dynamic>{
      'EmailOrPhone': instance.EmailOrPhone,
      'Password': instance.Password,
      'GrantType': instance.GrantType,
    };
