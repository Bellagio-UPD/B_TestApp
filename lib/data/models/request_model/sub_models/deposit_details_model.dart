import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/request_entity/details_entity.dart';

part 'deposit_details_model.g.dart';

@JsonSerializable()
class DepositDetails extends DetailsEntity {
  final String? Document;
  final String? Message;
  final String? RequestDate;
  final String? Location;
  final String? PackageId;
  final String? PackageName;

  const DepositDetails({
    this.Document,
    this.Message,
    this.RequestDate,
    this.Location,
    this.PackageId,
    this.PackageName
  });

  factory DepositDetails.fromJson(Map<String, dynamic> json) =>
      _$DepositDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$DepositDetailsToJson(this);
}
