part of 'feedback_cubit.dart';

abstract class FeedbacksState extends Equatable {
  final FeedbackModel? feedbackModel;
  final DioException? error;
  final List<FeedbackTableModel>? feedbackTableModel;

  const FeedbacksState(
      {this.feedbackModel, this.error, this.feedbackTableModel});

  @override
  List<Object?> get props => [feedbackModel, error, feedbackTableModel];
}

class FeedbacksInitial extends FeedbacksState {
  const FeedbacksInitial({FeedbackModel? model}) : super(feedbackModel: model);
}

class FeedbackSuccessState extends FeedbacksState {
  const FeedbackSuccessState({FeedbackModel? model})
      : super(feedbackModel: model);
}

class FeedbackErrorState extends FeedbacksState {
  const FeedbackErrorState({FeedbackModel? model, DioException? error})
      : super(feedbackModel: model, error: error);
}

class FeedbackTableInitialState extends FeedbacksState {
  const FeedbackTableInitialState({List<FeedbackTableModel>? feedbackModel})
      : super(feedbackTableModel: feedbackModel);
}

class FeedbackTableSuccessState extends FeedbacksState {
  const FeedbackTableSuccessState({List<FeedbackTableModel>? feedbackModel, DioException? error})
      : super(feedbackTableModel: feedbackModel, error: error);
}

class FeedbackTableErrorState extends FeedbacksState {
  const FeedbackTableErrorState({List<FeedbackTableModel>? feedbackModel, DioException? error})
      : super(feedbackTableModel: feedbackModel, error: error);
}
