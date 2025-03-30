import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/response_entity/response_entity.dart';
part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel extends ResponseEntity {
  // final Uint8List? qrCode;
  const ResponseModel({
    // this.qrCode,
    super.operation,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return _$ResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResponseModelToJson(this);
  }
}