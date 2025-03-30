import 'package:equatable/equatable.dart';
import 'details_entity.dart';

class RequestEntity extends Equatable {
  final String? RequestId;
  final String? Title;
  final String? Status;
  final DetailsEntity? Details; // Changed DetailsEntity to dynamic map
  final String? Priority;
  final String? RequestedDate;
  final String? DateOfCompletion;
  final String? CustomerId;
  final String? CustomerName; // Added CustomerName
  final String? RequestType;
  final String? RejectReason;
  final String? PResponder;
  final String? SResponder;
  final String? Delay; // Added Delay
  final String? Descriptions;
  final bool? IsLongTrip;



  const RequestEntity({
    this.RequestId,
    this.Title,
    this.Status,
    this.Details,
    this.Priority,
    this.RequestedDate,
    this.DateOfCompletion,
    this.CustomerId,
    this.CustomerName, // Added field
    this.RequestType,
    this.RejectReason,
    this.PResponder,
    this.SResponder,
    this.Delay, // Added field
    this.Descriptions,
    this.IsLongTrip
  });

  @override
  List<Object?> get props {
    return [
      RequestId,
      Title,
      Status,
      Details,
      Priority,
      RequestedDate,
      DateOfCompletion,
      CustomerId,
      CustomerName, // Added to props
      RequestType,
      RejectReason,
      PResponder,
      SResponder,
      Delay, // Added to props
      Descriptions,
      IsLongTrip
    ];
  }
}
