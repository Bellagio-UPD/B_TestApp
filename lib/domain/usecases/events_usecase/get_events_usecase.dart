import 'package:bellagio_mobile_user/data/models/events_model/events_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/events_repository/events_repository.dart';

import '../../../core/storage/data_state.dart';
import '../usecase/usecase.dart';

class GetEventsUsecase implements UseCase<DataState<List<EventsModel>>, void> {
  final EventsRepository _eventsRepository;

  GetEventsUsecase(this._eventsRepository);
  @override
  Future<DataState<List<EventsModel>>> call({void params}) {
    return _eventsRepository.getEventsRepository();
  }
}
