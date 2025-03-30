import 'package:bellagio_mobile_user/domain/entities/general_request_entity/general_request_entity.dart';
import 'package:bellagio_mobile_user/domain/entities/request_entity/details_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'general_request_model.g.dart';

@JsonSerializable()
class GeneralRequestModel extends DetailsEntity {
    final String? requestType;
  final String? note;
  const GeneralRequestModel({
    this.requestType,
    this.note
  });

  factory GeneralRequestModel.fromJson(Map<String, dynamic> json) =>
      _$GeneralRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralRequestModelToJson(this);
}
