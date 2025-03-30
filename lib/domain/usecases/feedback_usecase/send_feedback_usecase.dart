import 'package:bellagio_mobile_user/data/models/feedback_model/feedback_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/feedback_repository/feedback_repository.dart';

import '../../../core/storage/data_state.dart';
import '../../../data/models/response_model/response_model.dart';

class SendFeedbackUsecase {
  final FeedbackRepository feedbackRepository;

  SendFeedbackUsecase(this.feedbackRepository);

  Future<DataState<ResponseModel>> call(FeedbackModel feedbackModel) {
    return feedbackRepository.sendFeedback(feedbackModel);
  }
}
