import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/file_uploader_entity/file-uploader_response_entity.dart';

part 'file_uploader_response_model.g.dart';

@JsonSerializable()
class UploadImageResponseModel extends UploadImageResponseEntity {
  const UploadImageResponseModel({
    String? imageUrl,
  }) : super(imageUrl: imageUrl);

  factory UploadImageResponseModel.fromJson(Map<String, dynamic> json) {
    return _$UploadImageResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UploadImageResponseModelToJson(this);
  }
}
