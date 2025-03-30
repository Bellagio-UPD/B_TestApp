// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      CustomerId: json['CustomerId'] as String?,
      FirstName: json['FirstName'] as String?,
      LastName: json['LastName'] as String?,
      Email: json['Email'] as String?,
      ProfileImage: json['ProfileImage'] as String?,
      CoverImage: json['CoverImage'] as String?,
      Country: json['Country'] as String?,
      Phone: json['Phone'] as String?,
      Address: json['Address'] as String?,
      Age: (json['Age'] as num?)?.toInt(),
      Gender: json['Gender'] as String?,
      ManagerId: json['ManagerId'] as String?,
      LoyaltyProgramId: json['LoyaltyProgramId'] as String?,
      CustomerPackageId: json['CustomerPackageId'] as String?,
      BellagioId: json['BellagioId'] as String?,
      Points: (json['Points'] as num?)?.toInt(),
      IsValidated: json['IsValidated'] as bool?,
      OTPPoints: (json['OTPPoints'] as num?)?.toDouble(),
      RegistrationQR: json['RegistrationQR'] as String?,
      Deleted: json['Deleted'] as bool?,
      QId: json['QId'] as String?
    );

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'CustomerId': instance.CustomerId,
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'Email': instance.Email,
      'ProfileImage': instance.ProfileImage,
      'CoverImage': instance.CoverImage,
      'Country': instance.Country,
      'Phone': instance.Phone,
      'Address': instance.Address,
      'Age': instance.Age,
      'Gender': instance.Gender,
      'ManagerId': instance.ManagerId,
      'LoyaltyProgramId': instance.LoyaltyProgramId,
      'CustomerPackageId': instance.CustomerPackageId,
      'BellagioId': instance.BellagioId,
      'Points': instance.Points,
      'IsValidated': instance.IsValidated,
      'OTPPoints': instance.OTPPoints,
      'RegistrationQR': instance.RegistrationQR,
      'Deleted': instance.Deleted,
      'QId': instance.QId
    };
