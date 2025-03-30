// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_pickup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoneyPickupModel _$MoneyPickupModelFromJson(Map<String, dynamic> json) =>
    MoneyPickupModel(
      address: json['address'] as String?,
      time: json['time'] as String?,
      date: json['date'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$MoneyPickupModelToJson(MoneyPickupModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'time': instance.time,
      'date': instance.date,
      'note': instance.note,
    };
