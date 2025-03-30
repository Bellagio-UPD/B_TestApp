import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/domain/repositories/feedback_repository/feedback_repository.dart';
import 'package:bellagio_mobile_user/domain/usecases/usecase/usecase.dart';

import '../../../data/models/feedback_model/feedback_table_model.dart';

class GetFeedbacktableUsecase
    implements UseCase<DataState<List<FeedbackTableModel>>, void> {
  final FeedbackRepository _feedbackRepository;

  GetFeedbacktableUsecase(this._feedbackRepository);
  @override
  Future<DataState<List<FeedbackTableModel>>> call({void params}) {
    return _feedbackRepository.getFeedbackDropdownLists();
  }
}
