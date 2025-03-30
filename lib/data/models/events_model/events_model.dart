import 'package:bellagio_mobile_user/domain/entities/events_entity/events_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'events_model.g.dart';

@JsonSerializable()
class EventsModel extends EventsEntity {
  const EventsModel({
    super.EventId,
    super.Name,
    super.Date,
    super.Description,
    super.Category,
    super.Status,
    super.Poster,
    super.Deleted,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) =>
      _$EventsModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventsModelToJson(this);
}
