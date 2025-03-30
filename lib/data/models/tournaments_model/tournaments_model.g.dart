// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournaments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TournamentsModel _$TournamentsModelFromJson(Map<String, dynamic> json) =>
    TournamentsModel(
      TournamentId: json['TournamentId'] as String?,
      Name: json['Name'] as String?,
      StartDate: json['StartDate'] as String?,
      EndDate: json['EndDate'] as String?,
      Prize: json['Prize'] as String?,
      Poster:
          (json['Poster'] as List<dynamic>?)?.map((e) => e as String).toList(),
      Status: json['Status'] as String?,
      Deleted: json['Deleted'] as bool?,
    );

Map<String, dynamic> _$TournamentsModelToJson(TournamentsModel instance) =>
    <String, dynamic>{
      'TournamentId': instance.TournamentId,
      'Name': instance.Name,
      'StartDate': instance.StartDate,
      'EndDate': instance.EndDate,
      'Prize': instance.Prize,
      'Poster': instance.Poster,
      'Status': instance.Status,
      'Deleted': instance.Deleted,
    };
