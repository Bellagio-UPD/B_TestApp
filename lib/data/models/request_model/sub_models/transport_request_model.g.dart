// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransportRequestModel _$TransportRequestModelFromJson(
        Map<String, dynamic> json) =>
    TransportRequestModel(
      PickupLocation: json['PickupLocation'] as String?,
      DropoffLocation: json['DropoffLocation'] as String?,
      PickupTime: json['PickupTime'] as String?,
      VehicleType: json['VehicleType'] as String?,
      CustomerId: json['CustomerId'] as String?,
      CustomerName: json['CustomerName'] as String?,
      TripType: json['TripType'] as String?,
    );

Map<String, dynamic> _$TransportRequestModelToJson(
        TransportRequestModel instance) =>
    <String, dynamic>{
      'PickupLocation': instance.PickupLocation,
      'DropoffLocation': instance.DropoffLocation,
      'PickupTime': instance.PickupTime,
      'VehicleType': instance.VehicleType,
      'CustomerId': instance.CustomerId,
      'CustomerName': instance.CustomerName,
      'TripType': instance.TripType,
    };
