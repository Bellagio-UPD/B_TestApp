// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gifts_model_new.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiftsModelNew _$GiftsModelNewFromJson(Map<String, dynamic> json) =>
    GiftsModelNew(
      TypeOfGift: json['TypeOfGift'] as String?,
      Avaialability: json['Avaialability'] as String?,
      Option: (json['Option'] as List<dynamic>?)
          ?.map((e) => OptionsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GiftsModelNewToJson(GiftsModelNew instance) =>
    <String, dynamic>{
      'TypeOfGift': instance.TypeOfGift,
      'Avaialability': instance.Avaialability,
      'Option': instance.Option,
    };
