import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/request_entity/details_entity.dart';

class DetailsEntityConverter implements JsonConverter<DetailsEntity?, Map<String, dynamic>?> {
  const DetailsEntityConverter();

  @override
  DetailsEntity? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return DetailsEntity.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(DetailsEntity? details) {
    return details?.toJson();
  }
}