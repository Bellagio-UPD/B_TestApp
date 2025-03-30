import 'package:bellagio_mobile_user/domain/entities/feedback_entity/feedback_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feedback_model.g.dart';

@JsonSerializable()
class FeedbackModel extends FeedbackEntity {
  const FeedbackModel({
    super.FeedbackId,
    super.Content,
    super.TableNumber,
    super.GamingServiceRating,
    super.FrontOfficeRating,
    super.FandBServiceRating,
    super.TableNStaffRating,
    super.CustomerId,
    super.deleted,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackModelToJson(this);
}
