
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/tournaments_entity/tournaments_entity.dart';

part 'tournaments_model.g.dart';

@JsonSerializable()
class TournamentsModel extends TournamentsEntity {
  const TournamentsModel({
    super.TournamentId,
    super.Name,
    super.StartDate,
    super.EndDate,
    super.Prize,
    super.Poster,
    super.Status,
    super.Deleted,
  });

  factory TournamentsModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentsModelToJson(this);
}
