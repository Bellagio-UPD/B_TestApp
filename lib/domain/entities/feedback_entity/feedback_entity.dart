import 'package:equatable/equatable.dart';

class FeedbackEntity extends Equatable {
  final String? FeedbackId;
  final String? Content;
  final String? TableNumber;
  final int? GamingServiceRating;
  final int? FrontOfficeRating;
  final int? FandBServiceRating;
  final int? TableNStaffRating;
  final String? CustomerId;
  final bool? deleted;

  const FeedbackEntity({
    this.FeedbackId,
    this.Content,
    this.TableNumber,
    this.GamingServiceRating,
    this.FrontOfficeRating,
    this.FandBServiceRating,
    this.TableNStaffRating,
    this.CustomerId,
    this.deleted,
  });

  @override
  List<Object?> get props {
    return [
      FeedbackId,
      Content,
      TableNumber, 
      GamingServiceRating,
      FrontOfficeRating,
      FandBServiceRating,
      TableNStaffRating,
      CustomerId,
      deleted,
    ];
  }
}
