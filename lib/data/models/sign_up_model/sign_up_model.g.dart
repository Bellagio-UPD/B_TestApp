// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpModel _$SignUpModelFromJson(Map<String, dynamic> json) => SignUpModel(
      CustomerId: json['CustomerId'] as String?,
      FirstName: json['FirstName'] as String?,
      LastName: json['LastName'] as String?,
      Email: json['Email'] as String?,
      ProfileImage: json['ProfileImage'] as String?,
      Phone: json['Phone'] as String?,
      Password: json['Password'] as String?,
      FBEmail: json['FBEmail'] as String?,
      CountryCode: json['CountryCode'] as String?,
      BellagioId: json['BellagioId'] as String?,
      Country: json['Country'] as String?,
    );

Map<String, dynamic> _$SignUpModelToJson(SignUpModel instance) =>
    <String, dynamic>{
      'CustomerId': instance.CustomerId,
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'Email': instance.Email,
      'ProfileImage': instance.ProfileImage,
      'Phone': instance.Phone,
      'Password': instance.Password,
      'FBEmail': instance.FBEmail,
      'CountryCode': instance.CountryCode,
      'BellagioId': instance.BellagioId,
      'Country': instance.Country,
    };
