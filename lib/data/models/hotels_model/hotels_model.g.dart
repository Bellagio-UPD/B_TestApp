// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotels_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelsModel _$HotelsModelFromJson(Map<String, dynamic> json) => HotelsModel(
      HotelId: json['HotelId'] as String?,
      Name: json['Name'] as String?,
      Location: json['Location'] as String?,
      Rating: (json['Rating'] as num?)?.toDouble(),
      Price: (json['Price'] as num?)?.toDouble(),
      Photo:
          (json['Photo'] as List<dynamic>?)?.map((e) => e as String).toList(),
      Deleted: json['Deleted'] as bool?,
    );

Map<String, dynamic> _$HotelsModelToJson(HotelsModel instance) =>
    <String, dynamic>{
      'HotelId': instance.HotelId,
      'Name': instance.Name,
      'Location': instance.Location,
      'Rating': instance.Rating,
      'Price': instance.Price,
      'Photo': instance.Photo,
      'Deleted': instance.Deleted,
    };
