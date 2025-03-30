import 'package:bellagio_mobile_user/data/models/events_model/events_model.dart';

import '../../../core/storage/data_state.dart';

abstract class EventsRepository {
  Future<DataState<List<EventsModel>>>getEventsRepository();
}