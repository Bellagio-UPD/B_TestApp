// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airports_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirportModel _$AirportModelFromJson(Map<String, dynamic> json) => AirportModel(
      countryCode: json['countryCode'] as String?,
      iata: json['iata'] as String?,
      airport: json['airport'] as String?,
      isDisabled: json['isDisabled'] as bool?,
    );

Map<String, dynamic> _$AirportModelToJson(AirportModel instance) =>
    <String, dynamic>{
      'countryCode': instance.countryCode,
      'iata': instance.iata,
      'airport': instance.airport,
      'isDisabled': instance.isDisabled,
    };
