import 'package:bellagio_mobile_user/data/models/feedback_model/feedback_model.dart';

import '../../../core/storage/data_state.dart';
import '../../../data/models/feedback_model/feedback_table_model.dart';
import '../../../data/models/response_model/response_model.dart';

abstract class FeedbackRepository {
  Future<DataState<ResponseModel>> sendFeedback(FeedbackModel feedbackModel);
  Future<DataState<List<FeedbackTableModel>>> getFeedbackDropdownLists();
}
