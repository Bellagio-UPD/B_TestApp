import 'dart:convert';
import 'package:bellagio_mobile_user/data/models/request_model/details_entity_converter.dart';
import 'package:bellagio_mobile_user/domain/entities/request_entity/details_entity.dart';
import 'package:bellagio_mobile_user/domain/entities/request_entity/request_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_model.g.dart';

@JsonSerializable()
class RequestModel extends RequestEntity {
  final String? RequestId;
  final String? Title;
  final String? Status;
  final DetailsEntity? Details;
  final String? Priority;
  final String? RequestedDate;
  final String? DateOfCompletion;
  final String? CustomerId;
  final String? CustomerName;
  final String? RequestType;
  final String? RejectReason;
  final String? PResponder;
  final String? SResponder;
  final String? Delay;
  final String? Descriptions;
  final bool? IsLongTrip;

  const RequestModel(
      {this.RequestId,
      this.Title,
      this.Status,
      this.Details,
      this.Priority,
      this.RequestedDate,
      this.DateOfCompletion,
      this.CustomerId,
      this.CustomerName,
      this.RequestType,
      this.RejectReason,
      this.PResponder,
      this.SResponder,
      this.Delay,
      this.Descriptions,
      this.IsLongTrip})
      : super(
            RequestId: RequestId,
            Title: Title,
            Status: Status,
            Details: Details,
            Priority: Priority,
            RequestedDate: RequestedDate,
            DateOfCompletion: DateOfCompletion,
            CustomerId: CustomerId,
            RequestType: RequestType,
            RejectReason: RejectReason,
            PResponder: PResponder,
            SResponder: SResponder,
            Descriptions: Descriptions,
            IsLongTrip: IsLongTrip);

  factory RequestModel.fromJson(Map<String, dynamic> json) =>
      _$RequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestModelToJson(this);
}
